# frozen_string_literal: true

module PUNK
  # @model Info
  # @property message(required) [string] some information for the user to see
  class Info < View
    args :message

    def process
      logger.info message
      'info'
    end

    protected

    def _dir
      File.join(__dir__, '..', 'templates')
    end
  end
end
