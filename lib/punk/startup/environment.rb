# frozen_string_literal: true

case PUNK.env
when "test", "development"
  require "amazing_print"
  require "byebug"
  require "rubocop"
  require "rubocop-rspec"
  require "rubocop-sequel"
end
