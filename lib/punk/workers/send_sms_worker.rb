# frozen_string_literal: true

module PUNK
  class SendSmsWorker < Worker
    args :to, :body

    def validate
      validates_type String, :to
      validates_phone :to
      validates_includes PUNK.get.plivo.whitelist, :to if !PUNK.env.test? && !PUNK.get.plivo.mock && PUNK.get.plivo.whitelist.present?
      validates_type String, :body
      validates_length_range 1..1600, :body
    end

    def process
      if PUNK.env.test? || PUNK.get.plivo.mock
        plivo = PUNK.cache.get(:plivo) || []
        message =
          {
            sent: Time.now.utc.to_s,
            from: PUNK.get.plivo.number,
            to: to,
            body: body
          }
        plivo.prepend(message)
        PUNK.cache.set(:plivo, plivo)
        unless PUNK.env.test?
          require 'launchy'
          Launchy.open("#{PUNK.get.app.url || 'http://localhost:3000'}/plivo.html")
        end
        return
      end

      require 'plivo'

      client = Plivo::RestClient.new(PUNK.get.plivo.auth_id, PUNK.get.plivo.auth_token)
      client.messages.create(PUNK.get.plivo.number, [to], body)
    end
  end
end
