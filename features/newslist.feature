Feature: NewsLists

  As a news reader
  So that I can re-read and share articles
  I want to be able to add articles to NewsLists

Background: Users and articles in database

  Given the following users exist:
  | name  | email              | password | password_confirmation |
  | user1 | myemail@test.com   | 123456   | 123456                |
  | user2 | youremail@test.com | 123456   | 123456                |

  And I am logged in as "user1"
  And I am on the profile page for "user1"

  And the following articles exist:
  | title    | content               | author     | url                       | summary           | published_at | id |
  | Article1 | Content for Article1. | Herp Derp  | www.awebsite.com/article1 | Article1 summary. | 2012-11-16 17:17:00    | 1  |
  | Article2 | Article2's content.   | Derpina A. | www.something.com/2       | Article2 summary. | 2012-11-16 17:17:00   | 2  |

Scenario: Creating a NewsList

  When I safely follow "Create NewsList"
  When I safely fill in "Name" with "Technology"
  And I safely follow "Create NewsList"
  Then I should safely see "Successfully created NewsList"
  And I should safely see "Technology"

Scenario: Adding an article to a created NewsList

  Given I have created the NewsList "Favorites"
  And I am on the page of article named "Article1"
  When I safely select "Favorites" from "Add to NewsList"
  Then I should safely see "Article added to NewsList."

Scenario: Renaming a NewsList

  Given I have created the NewsList "Entertainment"
  When I safely select "Edit NewsList" from "Entertainment"
  When I safely fill in "Name" with "Celebrities"
  And I safely follow "Save Changes"
  Then I should safely see "Successfully updated NewsList."

Scenario: Viewing another user's NewsList

  Given I am logged in as "user2"
  And I safely go to profile page for "user1"
  And I safely follow "Technology"
  Then I should safely be on the show page for "Technology"

Scenario: Viewing an article from a NewsList

  Given I have created the NewsList "Favorites"
  And I am on the page of article named "Article1"
  When I safely select "Favorites" from "Add to NewsList"
  When I safely follow "Favorites"
  And I safely follow "Article1"
  Then I should safely see "Content for Article1."
  
Scenario: Viewing a friend's articles from a NewsList

  Given I added "Article1" to my favorite articles
  And I am friends with "user2"
  And I am logged in as "user2"
  And I am on the profile page for "user1"
  And I safely follow "Favorites"
  Then I should safely see "Article1"
