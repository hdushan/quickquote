require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:unit)

Cucumber::Rake::Task.new(:e2e) do |t|
  t.cucumber_opts = "features --tags ~@ignore --format pretty"
end

task :chrome do
  ENV['CH'] = "true"
  Rake::Task['e2e'].invoke
end

task :headless do
  ENV['CH'] = "false"
  Rake::Task['e2e'].invoke
end

task :default => [:unit, :e2e]
