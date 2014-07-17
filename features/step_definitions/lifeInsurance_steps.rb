Given(/^I am on the SydneyTesters Life Insurance page$/) do
  visit "/"
  expect(page).to have_content('Sydney Testers Insurance')
  click_on "getlifequote"
  expect(page).to have_content('Sydney Testers Life Insurance')
end

When(/^I submit my  details '(\d+)', '(.*?)', '(.*?)' & '(.*?)' for a life insurance quote$/) do | age, gender, state, occupation |
  fill_in 'age', :with => age
  choose(gender)
  select(occupation, :from => 'occupation')
  select(state, :from => 'state')
  fill_in 'email', :with => "test@gmail.com"
  click_button 'Get Quote'
end

When(/^I submit my '(.*)' with incorrect values$/) do | age |
  fill_in 'age', :with => age
end

Then(/^I should see the correct '(.*)' shown$/) do | premium |
  expect(page).to have_content(premium)
end

When(/^I enter a.*valid email '(.*)'$/) do | email |
  fill_in 'email', :with => email
end

Then(/^I should see an error message that the '(.*)'$/) do | error_message |
  expect(page).to have_content(error_message)
end

Then(/^I should not see an error message that the '(.*)'$/) do | error_message |
  expect(page).to_not have_content(error_message)
end