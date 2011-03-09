require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "tangerine"
  gem.homepage = "http://github.com/factorylabs/tangerine"
  gem.license = "MIT"
  gem.summary = %Q{Ooyala Backlot API Wrapper}
  gem.description = %Q{Ooyala Backlot API Wrapper. Read more about the Ooyala Backlot API at http://www.ooyala.com/support/docs/backlot_api}
  gem.email = "anthony.navarre@factorylabs.com"
  gem.authors = ["Anthony Navarre"]

  # Dependencies
  gem.add_dependency 'httparty'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
