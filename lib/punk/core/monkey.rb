# frozen_string_literal: true

class Hash
  def sanitize
    merge(slice(:password, :secret, "password", "secret").transform_values { "***" })
  end
end
