# frozen_string_literal: true

module PUNK
  class ListSessionsAction < Action
    args :user

    def validate
      validates_not_null :user
      validates_not_empty :user
      return if user.blank?
      validates_type User, :user
    end

    def process
      present ListSessionsView, sessions: user.active_sessions.all
    end
  end
end
