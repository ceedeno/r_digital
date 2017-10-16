class RemoveRefereesSelectedFromUsersArticles < ActiveRecord::Migration[5.1]
  def change
    remove_column :users_articles, :referee_1_selected
    remove_column :users_articles, :referee_2_selected
    remove_column :users_articles, :referee_3_selected
  end
end
