# frozen_string_literal: true

require "aasm"

AASM::Configuration.hide_warnings = true

module PUNK
  Model = Class.new(Sequel::Model)
  Model.def_Model(self)
  class Model
    include AASM
    include Loggable

    plugin :validation_helpers
    plugin :timestamps, update_on_create: true
    plugin :boolean_readers
    plugin :uuid
    plugin :update_or_create
    plugin :defaults_setter
    plugin :touch
    plugin :many_through_many

    plugin PUNK::Plugins::Validation

    def validate
    end

    def inspect
      id.present? ? "#{id}|#{self}" : to_s
    end

    def self.sample_dataset(count = 1)
      order(Sequel.lit("random()")).limit(count)
    end

    def self.sample(count = 1)
      query = sample_dataset(count)
      count == 1 ? query.first : query.all
    end

    def self.symbolize(*names)
      names.each do |name|
        chain =
          Module.new do
            define_method(name) do |*args|
              super(*args)&.to_sym
            end
          end
        prepend chain
      end
    end
  end
end
