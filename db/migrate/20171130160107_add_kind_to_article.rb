class AddKindToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :kind, :integer
  end
end
