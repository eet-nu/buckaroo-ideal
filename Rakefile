#!/usr/bin/env rake
require "bundler/gem_tasks"

desc "Start a console with the Buckaroo::Ideal library loaded"
task :console do
  exec "irb -r ./lib/buckaroo-ideal"
end

# RSpec tasks:
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

# YARD tasks:
require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb']
  t.options = ['--readme', 'README.md', '--charset', 'utf-8']
end
