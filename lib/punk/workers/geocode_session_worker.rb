# frozen_string_literal: true

module PUNK
  class GeocodeSessionWorker < Worker
    args :session_id

    def validate
      validates_not_null :session_id
      validates_not_empty :session_id
    end

    def process
      require 'maxmind/db'

      session = Session[session_id]
      return if session.blank?

      path = 'tmp/GeoLite2-City.mmdb'
      GeoIPUpdateWorker.perform_now unless File.exist?(path)
      raise unless File.exist?(path)

      ip_address = session.remote_addr.to_s
      return if ip_address == '127.0.0.1'

      # TODO: cache IP lookup
      client = MaxMind::DB.new(path, mode: MaxMind::DB::MODE_MEMORY)
      result = client.get(ip_address)

      raise if result.blank?

      result.deep_symbolize_keys!
      city = result[:city][:names][:en] if result[:city].present?
      region = result[:subdivisions].map { |s| s[:names][:en] }.join(', ') if result[:subdivisions].present?
      session.update(client: session.client.merge(
        tz: result[:location][:time_zone],
        geo: {
          lat: result[:location][:latitude],
          lng: result[:location][:longitude]
        },
        location: {
          city: city,
          country: result[:country][:names][:en],
          region: region
        }
      ))

      session.save
    end
  end
end
