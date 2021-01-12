# frozen_string_literal: true

module PUNK
  class PlivoStore < View
    def process
      'plivo'
    end

    protected

    def _dir
      File.join(__dir__, '..', 'templates')
    end
  end
end
