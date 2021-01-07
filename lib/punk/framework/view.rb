# frozen_string_literal: true

module PUNK
  class View < Service
    include Renderable

    def self.present(**kwargs)
      profile_info("present", kwargs) { run(**kwargs) }
    end

    def process
      raise NotImplemented, "view must provide process method"
    end

    protected

    def on_success
      raise InternalServerError, "not a template: #{result}" unless result.is_a?(String)
      template(result)
    end

    def on_failure
      Fail.run(message: "view failed: #{self.class}", error_messages: errors.full_messages, status: invalid? ? 400 : 500) unless is_a?(Fail)
    end
  end
end
