class AddVolumeIdToJournal < ActiveRecord::Migration[5.1]
  def change

    add_column :journals, :volume_id, :integer

  end
end
