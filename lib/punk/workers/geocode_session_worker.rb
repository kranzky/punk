# frozen_string_literal: true

module PUNK
  class GeocodeSessionWorker < Worker
    args :session_id

    def validate
      validates_not_null :session_id
      validates_not_empty :session_id
    end

    def process
      require 'ipstack'

      session = Session[session_id]
      return if session.blank?

      ip_address = session.remote_addr.to_s
      return if ip_address == '127.0.0.1'

      return if PUNK.get.ipstack.api_key.blank?
      result = Ipstack::API.standard(ip_address).deep_symbolize_keys

      raise if result.blank?

      timezone = result[:time_zone][:code] if result[:time_zone].present?
      language = result[:location][:languages].first[:code] if result[:location].present? && result[:location][:languages].present?
      currency = result[:currency][:code] if result[:currency].present?
      session.update(data: session.data.merge(
        tz: timezone,
        lang: language,
        currency: currency,
        geo: {
          lat: result[:latitude],
          lng: result[:longitude]
        },
        location: {
          city: result[:city],
          region: result[:region_name],
          country: result[:country_name],
          continent: result[:continent_name]
        }
      ))

      session.save
    end
  end
end
