# frozen_string_literal: true

module PUNK
  class ListGroupsAction < Action
    args :user, :tenant

    def validate
      validates_not_null :user
      validates_not_empty :user
      return if user.blank?
      validates_not_null :tenant
      validates_not_empty :tenant
      return if tenant.blank?
      validates_type User, :user
      validates_type Tenant, :tenant
    end

    def process
      # TODO: repository here
      # an action takes arguments (that may be entities) and returns a view object
      present ListGroupsView, groups: user.groups_dataset.where(tenant: tenant).all
    end
  end
end
