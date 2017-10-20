class AddCheckedByDirectorToUsersArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :users_articles, :checked_by_director, :boolean, default: false
  end
end
