Feature: Friendship between users

Background: Users in Database

  Given the following users exist:
  |name |email        |password|password_confirmation|
  |user1|user1@dot.com|foobar  |foobar               |
  |user2|user2@dot.com|barfoo  |barfoo               |
  |user3|user3@dot.com|youbar  |youbar               |

  Scenario: Add user as a friend

    Given I am logged in as "user1"
    And I safely go to profile page for "user2"
    Then I should safely see "Add Friend"
    When I safely follow "Add Friend"
    Then I should safely see "Successfully invited friend"

  Scenario: Accepting friend request

    Given I am logged in as "user2"
    Then I should safely see "New friend requests!"
    When I safely follow "Confirm?"
    Then I should safely see "Successfully confirmed friend!"

  Scenario: Delete a friend

    Given I am logged in as "user1"
    And I safely go to profile page for "user2"
    Then I should safely see "Delete Friend"
    When I safely follow "Delete Friend"
    Then I should safely see "Successfully removed friend!"
