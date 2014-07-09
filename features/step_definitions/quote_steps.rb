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