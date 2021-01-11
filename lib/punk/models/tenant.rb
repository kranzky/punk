# frozen_string_literal: true

module PUNK
  # @model
  # @property id(required) [string] a unique identifier for the tenant
  # @property name(required) [string] the name of the tenant
  # @property icon(required) [string] an image URL
  class Tenant < PUNK::Model
    alias to_s name

    many_to_many :users
    one_to_many :groups

    def validate
      validates_presence :name
      validates_url :icon, allow_blank: true
      validates_presence :subdomain
      validates_subdomain :subdomain
      validates_presence :portal_id
      validates_integer :portal_id
      validates_unique :portal_id
    end
  end
end
