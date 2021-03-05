# frozen_string_literal: true

module PUNK
  class ShowUserView < View
    args :user

    def validate
      validates_not_null :user
      validates_type User, :user
    end

    def process
      "users/show"
    end

    protected

    def _dir
      File.join(__dir__, "..", "..", "templates")
    end
  end
end
