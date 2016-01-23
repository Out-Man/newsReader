When /I safely go to the edit page for "(.*)"$/ do |e1|
  step %Q{
    Given I am logged in as "#{@user.name}"
    And I go to the edit page for "#{e1}"
  }
end

When /I .* safely .* the show page for "(.*)"$/ do |e1|
  step %Q{
    Given I am logged in as "#{@user.name}"
    And I go to the show page for "#{e1}"
  }
end

When /I make "(.*)" private$/ do |e1|
  step %Q{
    Given I am logged in as "#{@user.name}"
    And I go to the edit page for "#{e1}"
    And I uncheck "Make Private?"
    And I follow "Save Changes"
  }
end

When /I safely check "(.*)"$/ do |e1|
  step %Q{
    Given I am logged in as "#{@user.name}"
    And I check "#{e1}"
  }
end

When /I safely uncheck "(.*)"$/ do |e1|
  step %Q{
    Given I am logged in as "#{@user.name}"
    And I uncheck "#{e1}"
  }
end

