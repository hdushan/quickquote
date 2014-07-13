require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:unit)

begin; require 'parallel_tests/tasks'; rescue LoadError; end

Cucumber::Rake::Task.new(:e2e) do |t|
  t.cucumber_opts = "features --tags ~@ignore --format pretty"
end

task :parallel_all do
    RAILS_ENV = 'test'
    Rake::Task['parallel:features'].invoke
end

task :chrome do
  ENV['CH'] = "true"
  Rake::Task['e2e'].invoke
end

task :chromeparallel do
  ENV['CH'] = "true"
  Rake::Task['parallel_all'].invoke
end

task :grid do
  ENV['REMOTE'] = "true"
  Rake::Task['e2e'].invoke
end

task :headless do
  ENV['CH'] = "false"
  Rake::Task['e2e'].invoke
end

task :headlessparallel do
  ENV['CH'] = "false"
  Rake::Task['parallel_all'].invoke
end

task :qa do
  ENV['TEST_ENV'] = "QA"
  Rake::Task['e2e'].invoke
end

task :qaparallel do
  ENV['TEST_ENV'] = "QA"
  Rake::Task['parallel_all'].invoke
end

task :default => [:unit, :e2e]

