class AddRefereesIdsToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :referee_1_id, :integer
    add_column :articles, :referee_2_id, :integer
    add_column :articles, :referee_3_id, :integer
  end
end
