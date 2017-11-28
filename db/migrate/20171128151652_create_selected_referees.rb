class CreateSelectedReferees < ActiveRecord::Migration[5.1]
  def change
    create_table :selected_referees do |t|
      t.integer :article_id
      t.integer :referee_1_id
      t.integer :referee_2_id
      t.integer :referee_3_id
      t.date :referee_assigned_date

      t.timestamps
    end
  end
end
