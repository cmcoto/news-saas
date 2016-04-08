class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title
      t.text :content
      t.string :url

      t.timestamps null: false
    end
  end
end
