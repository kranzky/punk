# frozen_string_literal: true

source 'https://rubygems.org'

# Language
ruby "2.6.6"

# Startup
gem 'bootsnap', '~> 1.5.1'

# Dependency Injection
gem 'dim', '~> 1.2.8'

# Loose Coupling
gem 'wisper', '~> 2.0.1'

# Logging
gem 'papertrail', '~> 0.11.0'
gem 'semantic_logger', '~> 4.7.4'

# Configuration
gem 'dotenv', '~> 2.7.6'
gem 'dot_hash', '~> 1.1.8'

# Commands
gem 'commander', '~> 4.5.2'

# CLI
gem 'pry', '~> 0.13.1'

# Rack Server
gem 'puma', '~> 5.1.1'
gem 'rack-cors', '~> 1.1.1'
gem 'rack-protection', '~> 2.1.0'
gem 'rack-ssl-enforcer', '~> 0.2.9'
gem 'rack-unreloader', '~> 1.7.0'

# Caching
gem 'dalli', '~> 2.7.11'

# Database
gem 'pg', '~> 1.2.3'
gem 'sequel_pg', '~> 1.14.0'

# ORM
gem 'sequel', '~> 5.40.0'

# State Machine
gem 'aasm', '~> 5.1.1'

# Authentication
gem 'http-accept', '~> 2.1.1'
gem 'maxmind-db', '~> 1.1.1'
gem 'rbnacl', '~> 7.1.1'
gem 'userstack', '~> 0.1.0'

# Jobs
gem 'sidekiq', '~> 6.1.2'
gem 'sidekiq-cron', '~> 1.2.0'

# Email
gem 'mailgun-ruby', '~> 1.2.0'

# SMS
gem 'plivo', '~> 4.15.1'

# HTTP Framework
gem 'roda', '~> 3.39.0'
gem 'roda-route_list', '~> 2.1.0'

# HTML Rendering
gem 'slim', '~> 4.1.0'

# JSON Rendering
gem 'jbuilder', '~> 2.10.1'
gem 'oj', '~> 3.10.18'
gem 'tilt-jbuilder', '~> 0.7.1'

# Documentation Generation
gem 'rdoc', '~> 6.3.0'
gem 'swagger_yard', '~> 1.0.4'

# Railsy
gem 'activesupport', '~> 6.1.0'

# Monitoring
gem 'sentry-raven', '~> 3.1.1'
gem 'skylight', '~> 4.3.2'

# Phone Numbers
gem 'phony', '~> 2.18.18'

# Development
group :development do
  gem 'gemfile_updater', '~> 0.1.0'
  gem 'juwelier', '~> 2.4.9'
end

# Testing
group :test do
  gem 'capybara', '~> 3.34.0'
  gem 'coveralls', '~> 0.8.23'
  gem 'factory_bot', '~> 6.1.0'
  gem 'faker', '~> 2.15.1'
  gem 'rack-test', '~> 1.1.0'
  gem 'rspec', '~> 3.10.0'
  gem 'rspec-its', '~> 1.3.0'
  gem 'rubocop', '~> 1.7.0'
  gem 'rubocop-rails', '~> 2.9.1'
  gem 'rubocop-rspec', '~> 2.1.0'
  gem 'rubocop-sequel', '~> 0.1.0'
  gem 'selenium-webdriver', '~> 3.142.7'
  gem 'timecop', '~> 0.9.2'
  gem 'vcr', '~> 6.0.0'
  gem 'webmock', '~> 3.11.0'
end

# Non-production
group :development, :test do
  gem 'amazing_print', '~> 1.2.2'
  gem 'byebug', '~> 11.1.3'
  gem 'launchy', '~> 2.5.0'
  gem 'pry-byebug', '~> 3.9.0'
end
