# frozen_string_literal: true

require "rbnacl"

module PUNK
  class ProveClaimService < Service
    args :session, :secret

    def validate
      validates_not_null :session
      validates_not_empty :session
      return if session.blank?
      session.timeout?
      validates_type Session, :session
      validates_state :session, :pending
      validates_event :session, :verify
    end

    def process
      session.increment_attempts
      session.reload
      raise BadRequest, "Too many attempts" if session.attempt_count >= 3
      hash = RbNaCl::PasswordHash.scrypt(secret, session.salt, 1_048_576, 16_777_216)
      proven = (session[:hash] == hash)
      session.verify! if proven
      proven
    end
  end
end
