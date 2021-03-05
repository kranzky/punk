# frozen_string_literal: true

FactoryBot.define do
  factory :tenant, class: "PUNK::Tenant" do
    to_create(&:save)

    name { Faker::Name.name }
    icon { Faker::Internet.url }
  end
end
