Feature: Sharing

  As a newsreader
  So that I can expose my friends to articles I find interesting
  I want to be able to share articles

Background: Users and articles in the database

  Given the following users exist:
  | name  | email              | password | password_confirmation |
  | user1 | myemail@test.com   | 123456   | 123456                |
  | user2 | youremail@test.com | 123456   | 123456                |

  And I am logged in as "user1"
  And I am on the profile page for "user1"
  And I am friends with "user2"

  And the following articles exist:
  | title    | content               | author     | url                       | summary           | published_at | id |
  | Article1 | Content for Article1. | Herp Derp  | www.awebsite.com/article1 | Article1 summary. | 2012-11-16 17:17:00    | 1  |
  | Article2 | Article2's content.   | Derpina A. | www.something.com/2       | Article2 summary. | 2012-11-16 17:17:00   | 2  |

Scenario: Sharing articles

  Given I am on the page of article named "Article1"
  When I safely follow "Share to friends"
  Then I should safely see "You've successfully shared this article with all your friends."

Scenario: Viewing shared articles

  Given I am logged in as "user2"
  And I am on the page of article named "Article1"
  And I safely follow "Share to friends"
  When I am logged in as "user1"
  Then I should safely see "Article2"
