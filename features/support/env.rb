require 'capybara/cucumber'
require_relative '../../app'
require 'selenium-webdriver'

if ENV['USE_HEADLESS_MODE'] == "true"
  @browser = :phantomjs
else
  @browser = :chrome
end 

if ENV['RUN_TESTS_PARALLELY'] == "true"
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => "http://localhost:4444/wd/hub",
      :desired_capabilities => Selenium::WebDriver::Remote::Capabilities.new({:browser_name=>@browser.to_s, :javascript_enabled=>true}))
  end
else
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => @browser)
  end
end 

Capybara.default_driver  = :selenium
Capybara.current_driver  = :selenium
Capybara.javascript_driver = :selenium
Capybara.default_wait_time = 2

#Capybara.save_and_open_page_path = File.expand_path(File.join(File.dirname(__FILE__), "../screenshots/"))

if ENV['TEST_AGAINST_QA_ENV'] == "true"
  Capybara.configure do |config|
    config.run_server = false
    config.app_host   = "http://sydneytesters.herokuapp.com"
  end
else
  Capybara.server_port = 9887 + ENV['TEST_ENV_NUMBER'].to_i
  Capybara.app = App.new
end

Before do
  Capybara.current_session.driver.browser.manage.window.resize_to(1920, 1080)
  Capybara.page.driver.browser.manage.window.maximize
end

After  do |scenario|
  if scenario.failed?
    Capybara.page.driver.browser.manage.window.maximize
    puts scenario.name
    puts scenario.to_sexp

    if scenario.outline?
      puts "Scenatio Outline ...."
    else
      puts "Scenatio  ...."
    end
    puts "Screenshot saved(not yet)"
    screenshot_name = "screenshot.png"
    puts "Screenshot saving: #{screenshot_name}"
    page.save_screenshot(screenshot_name, :full => true)
    puts "Screenshot saved: #{screenshot_name}"
  end
end
