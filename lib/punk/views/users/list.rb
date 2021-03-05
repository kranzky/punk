# frozen_string_literal: true

module PUNK
  class ListUsersView < View
    args :users

    def validate
      validates_not_null :users
      validates_type Array, :users
    end

    def process
      "users/list"
    end

    protected

    def _dir
      File.join(__dir__, "..", "..", "templates")
    end
  end
end
