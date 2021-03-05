# frozen_string_literal: true

# @resource Users
#
# Users can belong to many tenants and many groups.
PUNK.route("users") do
  require_session!
  require_tenant!

  # Retrieve the list of users visible to the authenticated user for a specific tenant or group.
  # @path [GET] /users
  # @parameter tenant_id(required) [string] The ID of a tenant visible to the authenticated user.
  # @parameter group_id [string] The ID of a group that belongs to the tenant.
  # @response [Array<User>] 200 List of users
  # @method get
  # @example 200
  #   [{
  #     "id": "deadbeef-1234-5678-abcd-000000000000",
  #     "name": "John Smith",
  #     "icon": "https://some.image/url"
  #   }]
  # @example 401
  #   {
  #     "message": "You must specify a tenant.",
  #     "errors": ["Cannot find tenant"]
  #   }
  #
  # route: GET /users
  get do
    if args[:group_id]
      perform PUNK::ListGroupUsersAction, group: current_user.groups_dataset[tenant: current_tenant, id: args[:group_id]]
    else
      perform PUNK::ListTenantUsersAction, tenant: current_tenant
    end
  end
end
