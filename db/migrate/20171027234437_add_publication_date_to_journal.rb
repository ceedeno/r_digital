class AddPublicationDateToJournal < ActiveRecord::Migration[5.1]
  def change
    add_column :journals, :publication_date, :date
  end
end
