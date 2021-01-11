# frozen_string_literal: true

FactoryBot.define do
  factory :group, class: 'PUNK::Group' do
    to_create(&:save)

    tenant

    name { Faker::Name.name }
    icon { Faker::Internet.url }
  end
end
