# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: 'PUNK::User' do
    to_create(&:save)

    name { Faker::Name.name }
    icon { Faker::Internet.url }
    email { Faker::Internet.email }
    phone { generate(:phone) }
  end
end
