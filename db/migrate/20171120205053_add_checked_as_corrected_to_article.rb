class AddCheckedAsCorrectedToArticle < ActiveRecord::Migration[5.1]
  def change
  	add_column :articles, :checked_as_corrected, :boolean, default: :false
  end
end
