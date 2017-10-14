class CreateTableUsersArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :users_articles do |t|
      t.integer :user_id
      t.integer :article_id
      t.integer :status
      t.text :correction_note

    end
  end
end
