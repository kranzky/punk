# frozen_string_literal: true

FactoryBot.define do
  factory :tenant_user_metadata, class: 'PUNK::TenantUserMetadata' do
    to_create(&:save)

    tenant
    user
  end
end
