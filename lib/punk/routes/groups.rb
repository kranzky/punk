# frozen_string_literal: true

# @resource Groups
#
# Each tenant can have many groups.
PUNK.route("groups") do
  require_session!
  require_tenant!

  # Retrieve the list of groups visible to the authenticated user for a specific tenant.
  # @path [GET] /groups
  # @parameter tenant_id(required) [string] An email address or mobile phone number.
  # @response [Array<Group>] 200 List of groups
  # @method get
  # @example 200
  #   [{
  #     "id": "deadbeef-1234-5678-abcd-000000000000",
  #     "name": "Cool Group",
  #     "icon": "https://some.image/url"
  #   }]
  # @example 401
  #   {
  #     "message": "You must specify a tenant.",
  #     "errors": ["Cannot find tenant"]
  #   }
  #
  # route: GET /groups
  get do
    perform PUNK::ListGroupsAction, user: current_user, tenant: current_tenant
  end
end
