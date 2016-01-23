Given /the following articles exist/ do |articles_table|
	feed = Feed.create!(feed_url: "fake_url", name: "feed name")
  articles_table.hashes.each do |article|
    a = Article.create!(article)
    a.update_attributes(feed_id: feed.id)
  end
end

When /I try to go to article that does not exist/ do
  visit "/articles/12332"
end

Given /^I added "(.*)" to my favorite articles$/ do |article|
  step %Q{I am on the page of article named "#{article}"}
  step %Q{I safely follow "Add to Favorite"}
end

