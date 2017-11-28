class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.string :institution
      t.string :phone
      t.string :address
      t.string :country
      t.string :bio
      t.string :web_site
      t.string :speciality

      t.timestamps
    end
  end
end
