class CleanUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :gender
    remove_column :users, :institution
    remove_column :users, :phone
    remove_column :users, :address
    remove_column :users, :country
    remove_column :users, :bio
    remove_column :users, :web_site
    remove_column :users, :speciality

  end
end
