# frozen_string_literal: true

module PUNK
  class ListTenantUsersAction < Action
    args :tenant

    def validate
      validates_not_null :tenant
      validates_not_empty :tenant
      return if tenant.blank?
      validates_type Tenant, :tenant
    end

    def process
      present ListUsersView, users: tenant.users
    end
  end
end
