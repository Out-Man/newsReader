class CreateFavoriteListArticleJoinTable < ActiveRecord::Migration
  def change
    create_table :articles_favorite_lists, :id => false do |t|
      t.integer :favorite_list_id
      t.integer :article_id
    end
  end
end
