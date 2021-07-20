# frozen_string_literal: true

source "https://rubygems.org"

# Startup
gem "bootsnap", "~> 1.7"

# Dependency Injection
gem "dim", "~> 1.2"

# Loose Coupling
gem "wisper", "~> 2.0"

# Logging
gem "papertrail", "~> 0.11"
gem "semantic_logger", "~> 4.8"

# Configuration
gem "dotenv", "~> 2.7"
gem "dot_hash", "~> 1.1"

# Commands
gem "commander", "~> 4.6"

# CLI
gem "pry", "~> 0.14"

# Rack Server
gem "puma", "~> 5.3"
gem "rack-cors", "~> 1.1"
gem "rack-protection", "~> 2.1"
gem "rack-ssl-enforcer", "~> 0.2"
gem "rack-unreloader", "~> 1.7"

# Caching
gem "dalli", "~> 2.7"

# Database
gem "pg", "~> 1.2"
gem "sequel_pg", "~> 1.14"

# ORM
gem "sequel", "~> 5.46"

# State Machine
gem "aasm", "~> 5.2"

# Authentication
gem "http-accept", "~> 2.1"
gem "ipstack", "~> 0.1"
gem "rbnacl", "~> 7.1"
gem "userstack", "~> 0.1"

# Jobs
gem "sidekiq", "~> 6.2"
gem "sidekiq-cron", "~> 1.2"

# Email
gem "mailgun-ruby", "~> 1.2"

# SMS
gem "plivo", "~> 4.19"

# HTTP Framework
gem "roda", "~> 3.46"
gem "roda-route_list", "~> 2.1"

# HTML Rendering
gem "slim", "~> 4.1"

# JSON Rendering
gem "jbuilder", "~> 2.11"
gem "oj", "~> 3.12"
gem "tilt-jbuilder", "~> 0.7"

# Documentation Generation
gem "rdoc", "~> 6.3"
gem "swagger_yard", "~> 1.0"

# Railsy
gem "activesupport", "~> 6.1"

# Monitoring
gem "sentry-ruby", "~> 4.6"
gem "sentry-sidekiq", "~> 4.6"
gem "skylight", "~> 5.1"

# Phone Numbers
gem "phony", "~> 2.19"

# Development
group :development do
  gem "bundler", "~> 1.17"
  gem "gemfile_updater", "~> 0.1"
  gem "juwelier", "~> 2.4"
end

# Testing
group :test do
  gem "coveralls_reborn", "~> 0.22"
  gem "factory_bot", "~> 6.2"
  gem "faker", "~> 2.18"
  gem "rack-test", "~> 1.1"
  gem "rspec", "~> 3.10"
  gem "rspec-its", "~> 1.3"
  gem "rubocop-rails", "~> 2.11"
  gem "rubocop-rspec", "~> 2.4"
  gem "rubocop-sequel", "~> 0.2"
  gem "timecop", "~> 0.9"
  gem "vcr", "~> 6.0"
  gem "webmock", "~> 3.13"
end

# Non-production
group :development, :test do
  gem "amazing_print", "~> 1.3"
  gem "byebug", "~> 11.1"
  gem "launchy", "~> 2.5"
  gem "standard", "~> 1.1"
end
