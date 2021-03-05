# frozen_string_literal: true

module PUNK
  class VerifySessionAction < Action
    args :session, :secret

    def validate
      validates_not_null :session
      validates_not_empty :session
      return if session.blank?
      validates_not_null :secret
      return if secret.blank?
      validates_type Session, :session
      validates_state :session, :pending
      validates_event :session, :verify
    end

    def process
      verify = ProveClaimService.run(session: session, secret: secret)
      raise BadRequest, "Secret is incorrect" unless verify.result == true
      present Info, message: "We have succesfully verified your identity.  Welcome to GroupFire!"
    end
  end
end
