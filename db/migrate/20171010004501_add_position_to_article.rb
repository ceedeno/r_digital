class AddPositionToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :position, :integer, default: 0
  end
end
