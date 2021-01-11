# frozen_string_literal: true

module PUNK
  # @model
  # @property id(required) [string] a unique identifier for the group
  # @property name(required) [string] the name of the group
  # @property icon(required) [string] an image URL
  class Group < PUNK::Model
    alias to_s name

    many_to_one :tenant
    many_to_many :users

    def validate
      validates_presence :tenant
      validates_presence :name
      validates_url :icon, allow_blank: true
    end
  end
end
