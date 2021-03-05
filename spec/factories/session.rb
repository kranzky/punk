# frozen_string_literal: true

FactoryBot.define do
  factory :session, class: "PUNK::Session" do
    to_create(&:save)

    identity

    remote_addr { Faker::Internet.ip_v4_address }
    user_agent { Faker::Internet.user_agent }
  end
end
