require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:rspec)

Cucumber::Rake::Task.new(:default) do |t|
  t.cucumber_opts = "features --tags ~@ignore --format pretty"
end

task :default => :rspec
