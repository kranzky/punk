# frozen_string_literal: true

module PUNK
  class ListGroupUsersAction < Action
    args :group

    def validate
      validates_not_null :group
      validates_not_empty :group
      return if group.blank?
      validates_type Group, :group
    end

    def process
      present ListUsersView, users: group.users
    end
  end
end
