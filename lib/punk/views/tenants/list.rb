# frozen_string_literal: true

module PUNK
  class ListTenantsView < View
    args :tenants

    def validate
      validates_not_null :tenants
      validates_type Array, :tenants
    end

    def process
      "tenants/list"
    end

    protected

    def _dir
      File.join(__dir__, "..", "..", "templates")
    end
  end
end
