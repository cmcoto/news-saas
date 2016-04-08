class DocsController < ApplicationController
	def index
		@docs = Doc.all.order('created_at DESC')
	end

	def new
		@doc = Doc.new
	end

	def create
		@doc = Doc.new(doc_params)
		if @doc.save
			redirect_to docs_path, notice: "Document Created!"
		else
			render :new
		end
	end

	def edit
		@doc = Doc.find(params[:id])
	end

	def update
	    @doc = Doc.find(params[:id])

	    if @doc.update(doc_params)
	      redirect_to root_path, notice: "Document updated!"
	    else
	      render :edit
	    end
	end

	def destroy
	    @doc = Doc.find(params[:id])
	    @doc = Doc.destroy

	    flash.notice="Document '#{@doc.title}' was deleted"

	    redirect_to docs_path
	end

	private

	

	def doc_params
		params.require(:doc).permit(:title, :content, :url)
	end 
end
