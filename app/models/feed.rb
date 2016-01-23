class Feed < ActiveRecord::Base
	require 'feedzirra'
  attr_accessible :feed_url, :name
  after_create :add_article, :create_name
  has_many :articles
  has_and_belongs_to_many :feeds_lists

  def self.update_all
  	Feed.all.each do |feed|
 			feedzirra_feed = Feedzirra::Feed.fetch_and_parse(feed.feed_url)
 			add_articles(feedzirra_feed.entries, feed)
 		end
  end

=begin
   
  There is currently a bug with Feedzirra::Feed.update, so we are using a workaround right now
  which is less efficient but at least working.
  https://groups.google.com/forum/?fromgroups=#!topic/feedzirra/mSTpyDlTCpg

  def self.update_continuously(delay_interval = 15.minutes)
 		Feed.all.each do |feed|
 			feedzirra_feed = Feedzirra::Feed.fetch_and_parse(feed.feed_url)
	    loop do
	      sleep delay_interval
	      feedzirra_feed = Feedzirra::Feed.update(feedzirra_feed)
	      add_articles(feedzirra_feed.new_entries, feed) if feedzirra_feed.updated
	    end
	  end
  end
=end



	  def add_article
	  	feedzirra_feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
	  	Feed.add_articles(feedzirra_feed.entries, self) unless (feedzirra_feed == 0 || feedzirra_feed.nil? || feedzirra_feed == {})
	 	end

	 	def create_name
	 		feedzirra_feed = Feedzirra::Feed.fetch_and_parse(self.feed_url)
	 		self.update_attributes(name: feedzirra_feed.title) unless (feedzirra_feed == 0 || feedzirra_feed.nil? || feedzirra_feed == {})
	 	end

	  def self.add_articles(entries, feed)
	    entries.each do |entry|
	      unless Article.find_by_guid(entry.id)
	        Article.create!(
	        	:feed_id			=> feed.id,
	          :title        => entry.title,
	          :author				=> entry.author,
	          :summary      => entry.summary,
	          :content			=> entry.content,
	          :url          => entry.url,
	          :published_at => entry.published,
	          :guid         => entry.id,
            :image_url    => Article.extract_img(entry.summary)
	        )
	      end
	    end
	  end
end
