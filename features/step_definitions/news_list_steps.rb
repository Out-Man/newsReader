Given /^I have created the NewsList "(.*?)"$/ do |arg1|
  step %Q{When I safely follow "Create NewsList"}
  step %Q{When I safely fill in "Name" with "Technology"}
  step %Q{And I safely follow "Create NewsList"}
end
