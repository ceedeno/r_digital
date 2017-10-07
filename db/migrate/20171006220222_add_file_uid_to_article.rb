class AddFileUidToArticle < ActiveRecord::Migration[5.1]
  def change
  	add_column :articles, :file_uid, :string
  end
end
