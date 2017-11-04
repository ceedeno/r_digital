class AddRefereeAssignedDate < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :referee_assigned_date, :date
  end
end
