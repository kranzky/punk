# frozen_string_literal: true

# @resource Tenants
#
# All resources in the system are relative to a particular tenant application.
PUNK.route('tenants') do
  require_session!

  # Retrieve the list of tenants visible to the authenticated user.
  # @path [GET] /tenants
  # @response [Array<Tenant>] 200 List of tenants
  # @method get
  # @example 200
  #   [{
  #     "id": "deadbeef-1234-5678-abcd-000000000000",
  #     "name": "Cool Tenant",
  #     "icon": "https://some.image/url"
  #   }]
  # @example 401
  #   {
  #     "message": "You are not authenticated.",
  #     "errors": ["Cannot find session"]
  #   }
  #
  # route: GET /tenants
  get do
    perform PUNK::ListTenantsAction, user: current_user
  end
end
