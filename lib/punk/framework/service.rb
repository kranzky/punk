# frozen_string_literal: true

require 'active_support/string_inquirer'

module PUNK
  class Service < Runnable
    include Loggable
    include Publishable

    delegate :ready?, to: :_state
    delegate :invalid?, to: :_state
    delegate :success?, to: :_state
    delegate :failure?, to: :_state

    def self.run(**kwargs)
      service = new
      service.send(:_init, **kwargs)
      service.send(:_run)
      hijack = service.send(:_callbacks)
      service.is_a?(View) && hijack.is_a?(View) ? hijack : service
    end

    def result
      @_result
    end

    def process
      raise NotImplemented, "view must provide process method"
    end

    protected

    def _state
      ActiveSupport::StringInquirer.new(@_state.to_s)
    end

    def on_success; end

    def on_failure; end

    private

    def _init(**kwargs)
      @_state = :ready
      @_result = nil
      _init_runnable(kwargs)
    end

    def _run
      unless ready?
        errors.add(:raised, e.message)
        @_state = :failure
        return
      end
      unless valid?
        @_state = :invalid
        return
      end
      @_result = process
      @_state = :success
    end

    def _callbacks
      success? ? on_success : on_failure
    end
  end
end
