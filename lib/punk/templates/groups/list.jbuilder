# frozen_string_literal: true

json.array!(groups) do |group|
  json.id group.id
  json.name group.name
  json.icon group.icon
end
