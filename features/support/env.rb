require 'capybara/cucumber'
require 'phantomjs'
require_relative '../../app'
require 'selenium-webdriver'

class Capybara::Server
private
  def find_available_port
    @port = 9887 + ENV['TEST_ENV_NUMBER'].to_i
    Capybara.server_port = @port
  end
end

puts "ENV['TEST_ENV']" + " : " + ENV['TEST_ENV'].to_s
puts "ENV['REMOTE']" + " : " + ENV['REMOTE'].to_s
puts "ENV['CH']" + " : " + ENV['CH'].to_s

if ENV['TEST_ENV'] == 'QA'
  if ENV['REMOTE'] == 'true'
    caps = Selenium::WebDriver::Remote::Capabilities.chrome
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app,
        :browser => :remote,
        :url => "http://localhost:4444/wd/hub",
        :desired_capabilities => caps)
    end
    Capybara.app_host = "http://rocky-brook-3953.herokuapp.com"
    Capybara.default_driver  = :selenium
    Capybara.run_server = false
  else
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
    Capybara.app_host = "http://rocky-brook-3953.herokuapp.com"
    Capybara.default_driver  = :selenium
    Capybara.run_server = false
  end
else
  if ENV['CH'] == 'true'
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
  elsif ENV['REMOTE'] == 'true'
    caps = Selenium::WebDriver::Remote::Capabilities.chrome
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app,
        :browser => :remote,
        :url => "http://localhost:4444/wd/hub",
        :desired_capabilities => caps)
    end
  else
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :phantomjs)
    end
  end
  Capybara.app = App.new
end



  