class CreateVolumes < ActiveRecord::Migration[5.1]
  def change
    create_table :volumes do |t|
      t.integer :number
      t.integer :pages
      t.date :creation_date

      t.timestamps
    end
  end
end
