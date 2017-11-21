class AddLanguageToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :language, :string,  default: ''
  end
end
