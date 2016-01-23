class RenameNewsListToFeedsList < ActiveRecord::Migration
  def self.up
    rename_table :news_lists, :feeds_lists
  end

 	def self.down
    rename_table :feeds_lists, :news_lists
 	end
end
