require 'spec_helper'

describe Feed do
	before :each do
		@feed = Feed.create(:feed_url => "http://feeds.feedburner.com/railscasts")
	end

	#can't stop because of the infinite loop
	#@describe 'update feed' do
	#	it 'should call the model method that adds articles if the feed has been updated' do
	#		feedzirra_feed = Feedzirra::Feed.fetch_and_parse(@feed.feed_url)
	#		Feedzirra::Feed.should_receive(:fetch_and_parse).with(@feed.feed_url)
	#		Feedzirra::Feed.should_receive(:update)
	#		Feed.update_continuously(1.second)
	#	end
	#end
		
	describe 'add articles' do
		it 'should create Article entries for each item in the input unless an entry for that article already exists' do
		  feedzirra_feed = Feedzirra::Feed.fetch_and_parse(@feed.feed_url)
			Feed.add_articles(feedzirra_feed.entries, @feed)
			entry = feedzirra_feed.entries.first
			article = Article.find(:all, conditions: {title: entry.title}).first
			article.title.should == entry.title
			article.author.should == entry.author
			article.summary.should == entry.summary
			article.content.should == entry.content
			article.url.should == entry.url
			article.published_at.should == entry.published
			article.guid.should == entry.id
		end
	end
end
