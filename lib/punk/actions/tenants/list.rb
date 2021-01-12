# frozen_string_literal: true

module PUNK
  class ListTenantsAction < Action
    args :user

    def validate
      validates_not_null :user
      validates_not_empty :user
      return if user.blank?
      validates_type User, :user
    end

    def process
      present ListTenantsView, tenants: user.tenants_dataset.order(:name).all
    end
  end
end
