# frozen_string_literal: true

require 'rbnacl'

module PUNK
  class ChallengeClaimService < Service
    args :session

    def validate
      validates_not_null :session
      validates_not_empty :session
      return if session.blank?
      validates_type Session, :session
      validates_state :session, :created
      validates_event :session, :challenge
    end

    def process
      secret = SecretService.run.result
      salt = RbNaCl::Random.random_bytes(RbNaCl::PasswordHash::SCrypt::SALTBYTES)
      hash = RbNaCl::PasswordHash.scrypt(secret, salt, 1_048_576, 16_777_216)
      session.update(salt: salt, hash: hash)
      session.challenge!
      identity = session.identity
      case identity.claim_type
      when :email
        SendEmailWorker.perform_async(
          from: 'GroupFire Accounts <noreply@groupfire.com>',
          to: identity.claim,
          subject: '[GroupFire] Verification Code',
          template: 'verify',
          tags: [:auth],
          variables: {
            name: identity.user&.name || 'New User',
            secret: secret
          }
        )
      when :phone
        SendSmsWorker.perform_async(
          to: identity.claim,
          body: "Your GroupFire verification code is: #{secret}."
        )
      end
    end
  end
end
