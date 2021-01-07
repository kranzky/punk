# frozen_string_literal: true

require 'dalli'

PUNK::Interface.register(:cache) do
  PUNK.profile_debug('cache_connect', servers: PUNK.get.cache.servers) do
    Dalli::Client.new(PUNK.get.cache.servers.split(','), PUNK.get.cache.options)
  end
end

PUNK.inject :cache
