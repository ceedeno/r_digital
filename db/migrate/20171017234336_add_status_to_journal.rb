class AddStatusToJournal < ActiveRecord::Migration[5.1]
  def change
    add_column :journals, :status, :integer, default: 0
  end
end
