class AddCoverToJournal < ActiveRecord::Migration[5.1]
  def change
    add_column :journals, :cover_uid, :string
  end
end
