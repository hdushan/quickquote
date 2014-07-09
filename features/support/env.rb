require 'capybara/cucumber'
require 'capybara/poltergeist'
require 'phantomjs'
require_relative '../../app'

Capybara.register_driver :poltergeist do |app|
  options = {
          :js_errors => true,
          :phantomjs_options => ['--load-images=no', '--disk-cache=false', '--local-storage-quota=0', '--max-disk-cache-size=0', '--local-storage-path=""'],
      }
  Capybara::Poltergeist::Driver.new(app, :phantomjs => Phantomjs.path, :timeout => 40)
end

Capybara.app = App.new

Capybara.javascript_driver = :poltergeist

  