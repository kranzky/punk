# encoding: utf-8

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
require 'juwelier'
Juwelier::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "punk"
  gem.homepage = "https://github.com/kranzky/punk"
  gem.license = "UNLICENSE"
  gem.summary = %Q{Punk! is an omakase web framework for rapid prototyping.}
  gem.description = %Q{}
  gem.email = "lloyd@kranzky.com"
  gem.authors = ["Lloyd Kranzky"]
  gem.required_ruby_version = ">= 2.6"
  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new

require 'yard'
YARD::Rake::YardocTask.new

task :default => :clean
