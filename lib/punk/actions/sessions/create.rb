# frozen_string_literal: true

require "uri"
require "phony"

module PUNK
  class CreateSessionAction < Action
    args :claim, :remote_addr, :user_agent

    def validate
      validates_not_null :claim
      validates_not_empty :claim
      validates_not_null :claim_type, message: "is not an email address or phone number"
      validates_email :claim if claim_type == :email
      validates_phone :claim if claim_type == :phone
      validates_not_null :remote_addr
      validates_not_empty :remote_addr
      validates_not_null :user_agent
      validates_not_empty :user_agent
    end

    def process
      PUNK.db.transaction do
        identity =
          Identity.find_or_create(claim: _normalize_claim) do |i|
            i.claim_type = claim_type
          end
        session = Session.create(identity: identity, remote_addr: remote_addr, user_agent: user_agent)
        ChallengeClaimService.run(session: session)
        IdentifySessionWorker.perform_async(session_id: session.id)
        message =
          case identity.claim_type
          when :email
            "We have sent a verification code to your email address. Please enter it to verify your identity."
          when :phone
            "We have sent a verification code to your phone number by SMS. Please enter it to verify your identity."
          end
        present PendingSessionView, session: session, message: message, status: 201
      end
    end

    def claim_type
      @claim_type ||= _guess_claim_type
    end

    private

    def _guess_claim_type
      return :email if URI::MailTo::EMAIL_REGEXP.match(claim)
      return :phone if Phony.plausible?(claim)
    end

    def _normalize_claim
      case claim_type
      when :email
        claim.downcase.strip
      when :phone
        phone = claim.strip
        phone = "+1#{phone}" unless /^[+]/.match?(phone)
        "+#{Phony.normalize(phone)}"
      end
    end
  end
end
