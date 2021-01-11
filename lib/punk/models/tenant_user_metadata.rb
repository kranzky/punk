# frozen_string_literal: true

module PUNK
  class TenantUserMetadata < PUNK::Model(:tenants_users)
    many_to_one :tenant
    many_to_one :user

    def validate
      validates_presence :tenant
      validates_presence :user
    end

    def to_s
      "#{tenant_id}|#{user_id}"
    end
  end
end
