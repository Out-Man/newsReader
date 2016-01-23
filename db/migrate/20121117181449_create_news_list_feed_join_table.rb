class CreateNewsListFeedJoinTable < ActiveRecord::Migration
  def change
    create_table :feeds_news_lists, :id => false do |t|
      t.integer :news_list_id
      t.integer :feed_id
    end
  end
end
