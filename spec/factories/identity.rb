# frozen_string_literal: true

FactoryBot.define do
  factory :identity, class: 'PUNK::Identity' do
    to_create(&:save)

    user

    claim_type { ['email', 'phone'].sample }
    claim do
      case claim_type
      when 'email'
        Faker::Internet.email
      when 'phone'
        generate(:phone)
      end
    end
  end
end
