# frozen_string_literal: true

case PUNK.task
when "spec"
  require "rspec"
  require "rspec/its"
  require "sidekiq/testing"
when "console"
  AwesomePrint.pry! if defined?(AwesomePrint)
end
