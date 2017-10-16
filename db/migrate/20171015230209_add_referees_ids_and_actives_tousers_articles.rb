class AddRefereesIdsAndActivesTousersArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :users_articles, :referee_1_id, :integer
    add_column :users_articles, :referee_2_id, :integer
    add_column :users_articles, :referee_3_id, :integer

    add_column :users_articles, :referee_1_selected, :bool
    add_column :users_articles, :referee_2_selected, :bool
    add_column :users_articles, :referee_3_selected, :bool

  end
end
