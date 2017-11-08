class AddSpecialityToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :speciality, :string
  end
end
