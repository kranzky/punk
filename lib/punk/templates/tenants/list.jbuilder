# frozen_string_literal: true

json.array!(tenants) do |tenant|
  json.id tenant.id
  json.name tenant.name
  json.icon tenant.icon
end
