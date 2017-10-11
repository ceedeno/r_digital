class AddFileNameTojournal < ActiveRecord::Migration[5.1]
  def change
    add_column :journals, :file_name, :string, default: ''
  end
end
