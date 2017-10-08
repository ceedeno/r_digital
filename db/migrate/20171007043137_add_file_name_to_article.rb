class AddFileNameToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :file_name, :string
  end
end
