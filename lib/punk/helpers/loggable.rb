# frozen_string_literal: true

module PUNK
  module Loggable
    extend ActiveSupport::Concern

    def logger
      self.class.logger
    end

    def profile_info(name, **kwargs, &block)
      self.class.profile_info(name, **kwargs, &block)
    end

    def profile_debug(name, **kwargs, &block)
      self.class.profile_debug(name, **kwargs, &block)
    end

    def profile_trace(name, **kwargs, &block)
      self.class.profile_trace(name, **kwargs, &block)
    end

    def exception(e, extra={})
      if ENV.key?('SENTRY_DSN')
        ::Raven.capture_exception(
          e,
          message: e.message,
          extra: extra,
          transaction: "Punk!"
        )
      end
      _clean(e)
      logger.error exception: e
    end

    private

    IGNORE = Gem.path + $LOAD_PATH

    def _clean(e, trim: false)
      _clean(e.cause, trim: true) if e.cause
      ignore = IGNORE.reject { |path| e.backtrace.first =~ /#{path}/ }
      skip = false
      e.backtrace.map! do |line|
        if trim || ignore.any? { |path| line =~ /#{path}/ }
          unless skip
            skip = true
            '...'
          end
        else
          skip = false
          line
        end
      end
      e.backtrace.compact!
    end

    class_methods do
      def logger
        SemanticLogger[name]
      end

      def profile_info(name, **kwargs)
        logger.info "Started #{name}", kwargs.sanitize.inspect
        logger.measure_info("Completed #{name}") { logger.tagged(name) { yield } }
      end

      def profile_debug(name, **kwargs)
        logger.debug "Started #{name}", kwargs.sanitize.inspect
        logger.measure_debug("Completed #{name}") { logger.tagged(name) { yield } }
      end

      def profile_trace(name, **kwargs)
        logger.trace "Started #{name}", kwargs.sanitize.inspect
        logger.measure_trace("Completed #{name}") { logger.tagged(name) { yield } }
      end
    end
  end
end
