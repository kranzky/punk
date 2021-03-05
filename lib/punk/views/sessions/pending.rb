# frozen_string_literal: true

module PUNK
  class PendingSessionView < View
    args :session, :message

    def validate
      validates_not_null :session
      validates_not_empty :session
      return if session.blank?
      validates_type Session, :session
      validates_state :session, :pending
      validates_not_null :message
      validates_not_empty :message
      validates_type String, :message
    end

    def process
      "sessions/pending"
    end

    protected

    def _dir
      File.join(__dir__, "..", "..", "templates")
    end
  end
end
