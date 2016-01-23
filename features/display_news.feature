Feature: Display news from various news networks

	As a news reader
	So that I have a single place to read all my news
	I want to read news from different networks

Background: news has been added to database
 
  Given the following articles exist:
  |title|author |published_at    |summary |
  |Test1|author1|December 5, 2001|summary1|
  |Test2|author2|October 2, 2010 |summary2|
  Given I am on the NewsReader Digest home page

Scenario: go to an article page

  Then I should see "Test1"
  And I should see "Test2"
  When I follow "Test1"
  Then I should be on the page of article named "Test1"
  And I should see "author1"
  And I should not see "author2"

Scenario: go to an article that does not exist

  When I try to go to article that does not exist
  Then I should be on the NewsReader Digest home page
  And I should see "That article could not be found"
