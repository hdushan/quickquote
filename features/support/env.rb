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

HEROKU_URL = "http://rocky-brook-3953.herokuapp.com"

puts "ENV['TEST_ENV']" + " : " + ENV['TEST_ENV'].to_s
puts "ENV['REMOTE']" + " : " + ENV['REMOTE'].to_s
puts "ENV['CH']" + " : " + ENV['CH'].to_s

def launchgrid
  caps = Selenium::WebDriver::Remote::Capabilities.chrome
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app,
      :browser => :remote,
      :url => "http://localhost:4444/wd/hub",
      :desired_capabilities => caps)
    end  
    if (ENV['TEST_ENV'] == 'QA')
      Capybara.app_host = HEROKU_URL
      Capybara.run_server = false
    end
    Capybara.default_driver  = :selenium
end     
  
def launchchrome
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :chrome)
  end
  if (ENV['TEST_ENV'] == 'QA')
    Capybara.app_host = HEROKU_URL
    Capybara.run_server = false
  end
  Capybara.default_driver  = :selenium
end
  
def launchheadless
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, :browser => :phantomjs)
  end
end      

if ENV['TEST_ENV'] == 'QA'
  if ENV['REMOTE'] == 'true'
    launchgrid
  else
    launchchrome
  end
else
  if ENV['CH'] == 'true'
    launchchrome
  else
    launchheadless
  end
  Capybara.app = App.new
end



  