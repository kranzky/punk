# frozen_string_literal: true

require "sequel/plugins/validation_helpers"
require_relative "../framework/plugins/validation"

module PUNK
  module Validatable
    include Sequel::Plugins::ValidationHelpers::InstanceMethods
    include PUNK::Plugins::Validation::InstanceMethods

    undef :validates_presence
    undef :validates_schema_types
    undef :validates_unique

    attr_accessor :errors

    def valid?
      @errors ||= Sequel::Model::Errors.new
      errors.clear
      validate
      errors.empty?
    end

    def validate
    end

    def validates_not_empty(atts, opts = Sequel::OPTS)
      validatable_attributes_for_type(:not_empty, atts, opts) { |_a, v, m| validation_error_message(m) if v.blank? }
    end

    def default_validation_helpers_options(type)
      case type
      when :not_empty
        {
          message: -> { "is empty" }
        }
      else
        Sequel::Plugins::ValidationHelpers::DEFAULT_OPTIONS[type]
      end
    end

    def get_column_value(name)
      value =
        begin
          instance_variable_get(name)
        rescue
          nil
        end
      value ||=
        begin
          send(name)
        rescue
          nil
        end
      value
    end
  end
end
