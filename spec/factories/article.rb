# spec/factories/article.rb

FactoryGirl.define do
  factory :article do
    feed_id "fake_feed_id"
    guid  "fake_guid"
    published_at 1.hour.ago
    summary "fake_summary"
    url "fake_url"
    author "fake_author"
    content "fake_content"
    title "fake_title"
    image_url "fake_image_url"
  end

  factory :feed do
    feed_url "http://www.engadget.com/rss.xml"
    name "Engadget"
  end

	factory :user do
    	sequence(:name)  { |n| "Person #{n}" }
    	sequence(:email) { |n| "person_#{n}@example.com"}   
    	password "foobar"
    	password_confirmation "foobar"

    	factory :admin do
      		admin true
    	end
  end

  factory :feeds_list do
    name "Example Newslist"
    user
  end

  factory :shared_list do
    user
  end
end
