# frozen_string_literal: true

require 'rubocop/rake_task'
require 'rspec/core/rake_task'

task default: %i[spec rubocop]

desc 'Run specs'
task(:spec) do
  RSpec::Core::RakeTask.new
end

desc 'Run rubocop'
task :rubocop do
  RuboCop::RakeTask.new
end
