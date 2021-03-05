# frozen_string_literal: true

require "sidekiq"

module PUNK
  class Worker < Runnable
    include Sidekiq::Worker

    def self.perform_now(**kwargs)
      worker = new
      worker.define_singleton_method :logger, -> { SemanticLogger["PUNK::SKQ"] }
      worker.send(:perform, **kwargs)
    end

    def perform(kwargs = {})
      @_started = Time.now.utc
      logger.info "Started #{self.class.name}", kwargs.sanitize.inspect
      logger.push_tags(self.class.name)
      _init_runnable(kwargs.deep_symbolize_keys)
      raise BadRequest, "validation failed" unless valid?
      process
      nil
    rescue BadRequest => e
      logger.error e.message
      logger.error errors.full_messages.to_sentence
      raise
    ensure
      duration = 1000.0 * (Time.now.utc - @_started)
      logger.pop_tags
      logger.info message: "Completed #{self.class.name}", duration: duration
      SemanticLogger.flush
    end
  end
end
