# frozen_string_literal: true

module PUNK
  class ListGroupsView < View
    args :groups

    def validate
      validates_not_null :groups
      validates_type Array, :groups
    end

    def process
      'groups/list'
    end

    protected

    def _dir
      File.join(__dir__, '..', '..', 'templates')
    end
  end
end
