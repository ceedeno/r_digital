class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :issn
      t.string :electronic_issn
      t.string :legal_deposit
      t.date :creation_date
      t.string :indexing

      t.timestamps
    end
  end
end
