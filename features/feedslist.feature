Feature: FeedsLists

  As a Newsreader Digest user
  So that I can read news of the same category
  I want to be able to create FeedsLists

Background: Users in database

  Given the following users exist:
  | name  | email              | password | password_confirmation |
  | user1 | myemail@test.com   | 123456   | 123456                |
  | user2 | youremail@test.com | 123456   | 123456                |

  And I am logged in as "user1"
  And I am on the profile page for "user1"

Scenario: Creating a FeedsList

  When I safely follow "Create FeedsList"
  And I safely fill in "Name" with "Technology"
  And I safely select "Engadget" from "Available Feeds"
  And I safely follow "Create FeedsList"
  Then I should safely see "Successfully created FeedsList"
  And I should safely see "Technology"

Scenario: Creating a FeedsList sadpath: no name

  When I safely follow "Create FeedsList"
  And I safely select "Engadget" from "Available Feeds"
  And I safely follow "Create FeedsList"
  Then I should safely see "Name can't be blank"

Scenario: Editing a FeedsList

  When I safely go to the edit page for "Technology"
  And I safely select "Techcrunch" from "Available Feeds"
  And I safely follow "Save Changes"
  Then I should safely see "Successfully updated FeedsList"

Scenario: Editing a FeedsList sadpath: no name

  When I safely go to the edit page for "Technology"
  And I safely fill in "Name" with ""
  And I safely follow "Save Changes"
  Then I should safely see "Name can't be blank"

Scenario: Privating a FeedsList

  When I safely go to the edit page for "Technology"
  And I safely check "Make Private?"
  And I safely follow "Save Changes"
  Then I should safely see "Successfully updated FeedsList"
  Given I am logged in as "user2"
  And I safely go to profile page for "user1"
  Then I should safely not see "Technology"

Scenario: Unprivating a FeedsList

  Given I am logged in as "user1"
  When I safely go to the edit page for "Technology"
  And I safely uncheck "Make Private?"
  And I safely follow "Save Changes"
  Then I should safely see "Successfully updated FeedsList"
  Given I am logged in as "user2"
  And I safely go to profile page for "user1"
  Then I should safely see "Technology"

Scenario: Viewing another user's FeedsList

  Given I am logged in as "user2"
  And I safely go to profile page for "user1"
  And I safely follow "Technology"
  Then I should safely be on the show page for "Technology"

Scenario: Attempting to view a private FeedsList

  Given I am logged in as "user1"
  And I make "Technology" private
  Then I am logged in as "user2"
  And I should safely go to the show page for "Technology"
  Then I should safely see "You are trying to access a private FeedsList"
