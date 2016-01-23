Feature: Personal Profile Page

  As a social network users
  So that I am able to connect to other news readers
  I want to have my own personal profile

Background: Some users are already in database

  Given the following users exist:
  | name  | email              | password | password_confirmation |
  | user1 | myemail@test.com   | 123456   | 123456                |
  | user2 | youremail@test.com | 123456   | 123456                |

  And I am not logged in

Scenario: Make sure you can see Log In and Sign Up

  Given I am on the NewsReader Digest home page
  Then I should see "Log In"
  And I should see "Sign Up"

Scenario: Sign up for new account

  Given I am on the NewsReader Digest home page
  And I follow "Sign Up"
  When I fill in the Signup form
  And I press "Create Account"
  Then I should be on the profile page for "John Doe"
  And I should see "Welcome to Newsreader Digest!"

Scenario: Sign up for new account sad path

  Given I am on the NewsReader Digest home page
  And I follow "Sign Up"
  And I press "Create Account"
  Then I should see "There are errors, please double check."

Scenario: Unable to view another person's profile

  When I go to the profile page for "user1"
  Then I should see "Only signed in users can access this page. Please sign in."

Scenario: Should not see Friends favorited news section on home page

  When I am on the NewsReader Digest home page
  Then I should not see "News Read by Your Friends"

Scenario: Logging in - user exist

  Given I am on the NewsReader Digest home page
  When I follow "Log In"
  And I fill out the login form with correct information
  Then I should be on the profile page for "user1"
  And I should see "Welcome back, user1!"

Scenario: Logging in - user does not exist

  Given I am on the NewsReader Digest home page
  When I follow "Log In"
  And I fill out the login form with incorrect information
  Then I should see "Invalid email/password combination"

Scenario: View another user's profile page

  Given I am logged in as "user1"
  When I safely go to profile page for "user2"
  Then I should safely see "Name"
  And I should safely see "Email"

Scenario: Logging out

  Given I am logged in as "user1"
  When I safely follow "Log Out"
  Then I should safely see "You have logged out successfully."
  And I should see "Sign Up"

Scenario: Edit Profile UNsuccessfully

  Given I am logged in as "user1"
  Then I should safely see "Edit Profile"
  When I safely follow "Edit Profile"
  And I safely follow "Save Changes"
  Then I should safely see "There are errors, please double check."

Scenario: Edit profile successfully

  Given I am logged in as "user1"
  And I safely follow "Edit Profile"
  When I safely fill in the edit form
  And I safely follow "Save Changes"
  Then I should safely see "Profile updated"
