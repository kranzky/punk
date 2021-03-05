# frozen_string_literal: true

require "simplecov"
require "coveralls"
SimpleCov.start do
  add_filter "spec"
  add_filter "lib/punk/commands/auth.rb"
  add_filter "lib/punk/commands/generate.rb"
  add_filter "lib/punk/commands/http.rb"
  add_filter "lib/punk/commands/list.rb"
  add_filter "lib/punk/core/commands.rb"
  add_filter "lib/punk/framework/command.rb"
  add_filter "lib/punk/plugins/cors.rb"
  add_filter "lib/punk/plugins/ssl.rb"
  add_filter "lib/punk/startup/logger.rb"
end
Coveralls.wear!

require_relative "../lib/punk"

require "factory_bot"
require "faker"
require "timecop"
require "securerandom"
require "vcr"
require "rack/test"

Faker::Config.locale = "en-US"

FactoryBot.use_parent_strategy = false

VCR.configure do |c|
  c.ignore_localhost = true
  c.cassette_library_dir = "spec/vcr_cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

PUNK.init(task: "spec", config: {app: {name: "Punk Test"}}).exec

Sidekiq.logger = SemanticLogger["PUNK::SKQ"]

RSpec.shared_context "Punk" do # rubocop:disable RSpec/ContextWording
  include Rack::Test::Methods

  subject { last_response }

  def app
    PUNK.app
  end

  def login(claim)
    PUNK.cache.delete(:plivo)
    response =
      PUNK.app.call(
        "REQUEST_METHOD" => "POST",
        "PATH_INFO" => "/sessions",
        "CONTENT_TYPE" => "text/json",
        "SCRIPT_NAME" => "",
        "rack.input" => StringIO.new({claim: claim}.to_json)
      )
    response = ActiveSupport::JSON.decode(response[-1].first).deep_symbolize_keys
    slug = response[:slug]
    PUNK::SendSmsWorker.drain
    sms = PUNK.cache.get(:plivo).first
    PUNK.app.call(
      "REQUEST_METHOD" => "PATCH",
      "PATH_INFO" => "/sessions/#{slug}",
      "CONTENT_TYPE" => "text/json",
      "SCRIPT_NAME" => "",
      "rack.input" => StringIO.new({secret: sms[:body][-7..-2]}.to_json)
    )
  end

  def logout
    PUNK.app.call(
      "REQUEST_METHOD" => "DELETE",
      "PATH_INFO" => "/sessions",
      "SCRIPT_NAME" => "",
      "rack.input" => StringIO.new
    )
  end
end

module Helpers
  def valid_uuid?(data)
    data.split("-").map { |s| Integer(s, 16) }.length == 5
  end
end

FactoryBot.define do
  sequence :phone do
    phone = "+1#{Phony.normalize(Faker::PhoneNumber.cell_phone)}" until Phony.plausible?(phone)
    phone
  end

  sequence :uuid do
    SecureRandom.uuid
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.include Helpers

  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end
  config.before do
    Sidekiq::Worker.clear_all
  end

  config.around do |example|
    PUNK.db.transaction(rollback: :always, auto_savepoint: true) { example.run }
  end

  PUNK.commands(:spec, config)
end
