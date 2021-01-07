# frozen_string_literal: true

module PUNK
  class Action < Service
    def self.perform(**kwargs)
      action = profile_info("perform", kwargs) { run(**kwargs) }
      action.result
    end

    def process
      raise NotImplemented, "action must provide process method"
    end

    def present(view_class, **kwargs)
      raise InternalServerError, "not a view: #{view_class}" unless view_class < View
      view_class.run(**kwargs)
    end

    protected

    def on_success
      raise InternalServerError, "not a view: #{result}" unless result.is_a?(View)
    end

    def on_failure
      @_result = Fail.run(message: "action failed: #{self.class}", error_messages: errors.full_messages, status: invalid? ? 400 : 500)
    end
  end
end
