class AddRolAndGenderAndInstitutionAndPhoneAndAddressToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :integer, default: 0
    add_column :users, :gender, :integer, default: 0
    add_column :users, :institution, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :country, :string
    add_column :users, :bio, :string
    add_column :users, :web_site, :string

  end
end
