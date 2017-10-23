class AddTmdcmToArticle < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :tmdcm_1_id, :integer
    add_column :articles, :tmdcm_2_id, :integer

    add_column :articles, :tmdcm_1_review, :boolean, default: false
    add_column :articles, :tmdcm_2_review, :boolean, default: false


  end
end
