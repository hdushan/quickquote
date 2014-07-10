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

if ENV['CH'] == 'true'
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
else
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :phantomjs)
  end
end

Capybara.app = App.new



  