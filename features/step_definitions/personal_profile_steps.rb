#personal_profile_steps.rb

Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create!(:name => user[:name], :email => user[:email], :password => user[:password], :password_confirmation => user[:password_confirmation])
  end
end

Given /^(?:|I )am not logged in$/ do
  if body.include?("Log Out")
      click_link('logout')
  end
end

When /^I fill in the .* form$/ do
  fill_in('user_name', :with => 'John Doe')
  fill_in('user_email', :with => 'johndoe@test.com')
  fill_in('user_password', :with => '123456')
  fill_in('user_password_confirmation', :with => '123456')
end

When /^I safely fill in the .* form$/ do
  step %Q{
    Given I am logged in as "user1"
    And I fill in the edit form
  }
end

When /^I fill out the login form with correct information$/ do
  fill_in('session_email', :with => 'myemail@test.com')
  fill_in('session_password', :with => '123456')
  click_button "Log In"
end

When /^I fill out the login form with incorrect information$/ do
  fill_in('session_email', :with => 'myemail@test.com')
  fill_in('session_password', :with => '654321')
  click_button "Log In"
end

Given /^I am logged in$/ do
  if body.include?("Log In")
    click_link('login')
    step "I fill out the login form with correct information"
    click_button("Log In")
  end
end

Then /^I should see other information of that user$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see the "(.*?)" button$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

