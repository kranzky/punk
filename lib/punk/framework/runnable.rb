# frozen_string_literal: true

module PUNK
  class Runnable < Settings
    include Validatable

    def self.args(*args)
      PUNK.store.runnable ||= {}
      return PUNK.store.runnable[name] if PUNK.store.runnable.key?(name)
      PUNK.store.runnable[name] = args
    end

    def method_missing(key, *args, &block)
      val = super
      val = val.to_h if val.instance_of?(self.class)
      val
    end

    def respond_to_missing?(key, *args) # rubocop:disable Lint/UselessMethodDefinition
      super
    end

    private

    def _init_runnable(kwargs)
      args = self.class.args || []
      load(args.zip(Array.new(args.length, nil)).to_h)
      load(kwargs.select { |k, _| args.include?(k) })
    end
  end
end
