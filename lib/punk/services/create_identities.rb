# frozen_string_literal: true

module PUNK
  class CreateIdentitiesService < Service
    def process
      User.each do |user|
        if user.email.present?
          Identity.find_or_create(claim: user.email) do |i|
            i.claim_type = :email
            i.user = user
          end
        end
        if user.phone.present?
          Identity.find_or_create(claim: user.phone) do |i|
            i.claim_type = :phone
            i.user = user
          end
        end
      rescue Sequel::ValidationFailed => e
        logger.warn e.message
      end
      nil
    end
  end
end
