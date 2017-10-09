class CreateJournals < ActiveRecord::Migration[5.1]
  def change
    create_table :journals do |t|
      t.string :identifier
      t.string :editor
      t.string :publisher
      t.string :indexing
      t.string :copyright
      t.string :subject
      t.string :others
      t.integer :user_id

      t.timestamps
    end
  end
end
