class AddDefaultStatusToArticle < ActiveRecord::Migration[5.1]
  def change

    change_column_default :articles, :status, 0
  end
end
