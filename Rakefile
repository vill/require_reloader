#!/usr/bin/env rake
require "bundler/gem_tasks"

desc "run all integration tests"
task :test do
  system "cd test/resources/rails32-app; bundle exec rake test:integration; cd -"
  system "cd test/resources/rails31-app; bundle exec rake test:integration; cd -"
  system "cd test/resources/rails30-app; bundle exec rake test:integration; cd -"
end
