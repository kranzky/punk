# frozen_string_literal: true

module PUNK
  class IdentifySessionWorker < Worker
    args :session_id

    def validate
      validates_not_null :session_id
      validates_not_empty :session_id
    end

    def process
      require "userstack"

      session = Session[session_id]
      return if session.blank?

      return if PUNK.get.userstack.api_key.blank?
      client = Userstack::Client.new(PUNK.get.userstack.api_key, use_ssl: PUNK.get.userstack.use_ssl)
      result = client.parse(session.user_agent).deep_symbolize_keys

      raise if result[:success] == false || result[:type].nil?

      session.update(data: session.data.merge(
        os: {
          name: result[:os][:name],
          family: result[:os][:family],
          vendor: result[:os][:family_vendor]
        },
        browser: {
          name: result[:browser][:name],
          version: result[:browser][:version]
        },
        device: {
          name: result[:device][:name],
          brand: result[:device][:brand],
          type: result[:device][:type],
          mobile: result[:device][:is_mobile_device]
        }
      ))

      GeocodeSessionWorker.perform_now(session_id: session.id)
    end
  end
end
