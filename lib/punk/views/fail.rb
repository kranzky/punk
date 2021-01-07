# frozen_string_literal: true

module PUNK
  # @model Error
  # @property message(required) [string] some information for the user to see
  # @property errors(required) [Array<string>] a list of errors
  class Fail < View
    args :message, :error_messages, :status

    def process
      logger.warn "#{message} (#{status}): #{error_messages.to_sentence}"
      'fail'
    end

    protected

    def _dir
      File.join(__dir__, '..', 'templates')
    end
  end
end
