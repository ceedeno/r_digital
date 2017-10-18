class AddKeyWordToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :key_words, :string
  end
end
