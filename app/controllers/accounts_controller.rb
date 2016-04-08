class AccountsController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:new, :create]
  def new
    @account = Account.new
    @account.build_owner
  end

  def create
    @account = Account.new(account_params)
    if @account.valid?
      Apartment::Tenant.create(@account.subdomain)
      Apartment::Tenant.switch!(@account.subdomain)
      @account.save
      redirect_to new_user_session_url(subdomain: @account.subdomain) 
      #root_path, notice: 'Signed up successfully'
    else
      render action: 'new'
    end
  end
#El edit y Destroy los agregue de Hours...
  def edit
    @account = Account.find(account_params)
    Appartment::Tenant.switch!(@account.subdomain)
    redirect_to new_user_session_url(subdomain: @account.subdomain)
  end

  def destroy
    current_account.destroy
    Apartment::Tenant.drop(current_subdomain)
  end
  

private

  
  
  def account_params
    params.require(:account)
    .permit(:subdomain, owner_attributes: [:name, :email, :password, :password_confirmation])
  end
end