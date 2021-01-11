# frozen_string_literal: true

FactoryBot.define do
  factory :group_user_metadata, class: 'PUNK::GroupUserMetadata' do
    to_create(&:save)

    group
    user
  end
end
