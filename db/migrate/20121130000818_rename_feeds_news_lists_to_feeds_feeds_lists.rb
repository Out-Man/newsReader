class RenameFeedsNewsListsToFeedsFeedsLists < ActiveRecord::Migration
	def self.up
    rename_table :feeds_news_lists, :feeds_feeds_lists
    rename_column :feeds_feeds_lists, :news_list_id, :feeds_list_id
  end

 	def self.down
 		rename_column :feeds_feeds_lists, :feeds_list_id, :news_list_id
    rename_table :feeds_feeds_lists, :feeds_news_lists    
 	end
end
