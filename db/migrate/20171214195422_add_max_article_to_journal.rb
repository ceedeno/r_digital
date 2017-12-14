class AddMaxArticleToJournal < ActiveRecord::Migration[5.1]
  def change
    add_column :journals, :max_articles, :integer
  end
end
