# frozen_string_literal: true

json.array!(sessions) do |session|
  json.id session.id
  json.data session.data
end
