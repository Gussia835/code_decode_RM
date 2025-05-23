require "rake"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RuboCop::RakeTask.new(:lint) do |task|
  task.requires << "rubocop-performance" 
  task.requires << "rubocop-rspec"       
end

RSpec::Core::RakeTask.new(:test)

task default: %i[test lint]