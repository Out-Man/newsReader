class CreateNewsListArticleJoinTable < ActiveRecord::Migration
  def change
    create_table :articles_news_lists, :id => false do |t|
      t.integer :news_list_id
      t.integer :article_id
    end
  end
end
