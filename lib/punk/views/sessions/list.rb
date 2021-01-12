# frozen_string_literal: true

module PUNK
  class ListSessionsView < View
    args :sessions

    def validate
      validates_not_null :sessions
      validates_type Array, :sessions
    end

    def process
      'sessions/list'
    end

    protected

    def _dir
      File.join(__dir__, '..', '..', 'templates')
    end
  end
end
