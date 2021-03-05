# frozen_string_literal: true

module PUNK
  class Identity < PUNK::Model
    alias_method :to_s, :claim

    many_to_one :user
    one_to_many :sessions

    symbolize :claim_type

    def validate
      validates_presence :claim
      validates_presence :claim_type
      validates_unique :claim
      validates_includes [:email, :phone], :claim_type
      validates_email :claim if email?
      validates_phone :claim if phone?
    end

    def email?
      claim_type == :email
    end

    def phone?
      claim_type == :phone
    end
  end
end
