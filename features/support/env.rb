require 'capybara/cucumber'
require 'phantomjs'
require_relative '../../app'

if ENV['CH'] == 'true' # in case you wanna run it with selenium
  require 'selenium-webdriver'
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
else
  require 'capybara/poltergeist'
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(app, {
      js_errors: true,
      inspector: true,
      phantomjs_options: ['--load-images=no', '--ignore-ssl-errors=yes'],
      timeout: 120
    })
  end
  Capybara.javascript_driver = :poltergeist
end

Capybara.current_driver = ENV['CH'] == 'true' ? :selenium : :poltergeist
Capybara.app = App.new



  