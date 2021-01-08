# frozen_string_literal: true

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  warn e.message
  warn "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'
require 'juwelier'
Juwelier::Tasks.new do |gem|
  gem.name = "punk"
  gem.homepage = "https://github.com/kranzky/punk"
  gem.license = "The Unlicense"
  gem.summary = "Punk! is an omakase web framework for rapid prototyping."
  gem.description = ""
  gem.email = "lloyd@kranzky.com"
  gem.authors = ["Lloyd Kranzky"]
  gem.required_ruby_version = ">= 2.1"
  # dependencies defined in Gemfile
end
Juwelier::RubygemsDotOrgTasks.new

require 'yard'
YARD::Rake::YardocTask.new

task default: :clean
