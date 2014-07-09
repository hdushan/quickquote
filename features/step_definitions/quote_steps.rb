Given(/^I am on the SydneyTesters Home page '(.*)'$/) do | url |
  visit url
  expect(page).to have_content('Sydney Testers Life Insurance')
end

When(/^I submit my '(\d+)', '(.*)', '(.*)' & '(.*)'$/) do | age, gender, state, occupation |
  fill_in 'age', :with => age
  fill_in 'email', :with => "test@gmail.com"
  choose(gender)
  select(occupation, :from => 'occupation')
  select(state, :from => 'state')
  click_button 'Get Quote'
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