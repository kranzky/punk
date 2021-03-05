# frozen_string_literal: true

module PUNK
  # @model
  # @property id(required) [string] a unique identifier for the user
  # @property name(required) [string] the name of the user
  # @property icon(required) [string] an image URL
  class User < Model
    alias_method :to_s, :name

    many_to_many :tenants
    many_to_many :groups
    one_to_many :identities
    many_through_many :sessions, through: [[:identities, :user_id, :id], [:sessions, :identity_id, :id]]

    def validate
      validates_presence :name
      validates_url :icon, allow_blank: true
      validates_presence :email if phone.blank?
      validates_presence :phone if email.blank?
      validates_email :email, allow_blank: true
      validates_phone :phone, allow_blank: true
      validates_unique :email, allow_blank: true
      validates_unique :phone, allow_blank: true
    end

    def active_sessions
      sessions_dataset.where(Sequel.lit('"sessions"."state"') => "active")
    end
  end
end
