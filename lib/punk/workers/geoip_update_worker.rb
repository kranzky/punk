# frozen_string_literal: true

module PUNK
  class GeoIPUpdateWorker < Worker
    def process
      `geoipupdate -f config/geoip.conf -d tmp`
    end
  end
end
