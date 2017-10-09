class AddJournalIdToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :journal_id, :integer
  end
end
