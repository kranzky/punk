# frozen_string_literal: true

module PUNK
  class ClearSessionAction < Action
    args :session

    def validate
      validates_not_null :session
      validates_not_empty :session
      return if session.blank?
      validates_type Session, :session
      validates_state :session, :active
      validates_event :session, :clear
    end

    def process
      session.clear!
      present Info, message: "You have been logged out."
    end
  end
end
