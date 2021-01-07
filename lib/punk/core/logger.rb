# frozen_string_literal: true

require 'semantic_logger'

module PUNK
  include SemanticLogger::Loggable

  def self.profile_info(name, **kwargs)
    logger.info "Started #{name}", kwargs.sanitize.inspect
    logger.measure_info("Completed #{name}") { logger.tagged(name) { yield } }
  end

  def self.profile_debug(name, **kwargs)
    logger.debug "Started #{name}", kwargs.sanitize.inspect
    logger.measure_debug("Completed #{name}") { logger.tagged(name) { yield } }
  end

  def self.profile_trace(name, **kwargs)
    logger.trace "Started #{name}", kwargs.sanitize.inspect
    logger.measure_trace("Completed #{name}") { logger.tagged(name) { yield } }
  end

  SemanticLogger.default_level =
    case PUNK.store.args.task
    when 'console', 'script'
      :info
    when 'spec'
      :debug
    else
      :trace
    end
  SemanticLogger.add_appender(io: $stdout, formatter: :color)
end
