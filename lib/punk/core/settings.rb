# frozen_string_literal: true

require 'dot_hash'

module PUNK
  class Settings < DotHash::Settings
    alias key? has_key?

    delegate :inspect, to: :_inspect_hash

    def method_missing(key, *args, &block)
      match = /^(.*)([!?])$/.match(key)
      if match && key?(match[1]) && !key?(key)
        value = execute(match[1], *args, &block)
        case match[2]
        when '?'
          return value if value.is_a?(TrueClass) || value.is_a?(FalseClass)
        when '!'
          raise InternalServerError, "Value is nil: #{key}" if value.nil?
          return value
        end
      end
      super
    end

    def respond_to_missing?(key, *args)
      match = /^(.*)([!?])$/.match(key)
      key = match[1] if match && !key?(key)
      super
    end

    private

    def _inspect_hash
      to_h.inspect
    end
  end
end
