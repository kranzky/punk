# frozen_string_literal: true

module PUNK
  class SendEmailWorker < Worker
    args :from, :to, :subject, :template, :variables, :tags

    def validate
      validates_type String, :from
      validates_type String, :to
      validates_email :to
      validates_includes PUNK.get.mailgun.whitelist, :to if !PUNK.env.test? && !PUNK.get.mailgun.mock && PUNK.get.mailgun.whitelist.present?
      validates_type String, :subject
      validates_type String, :template
      validates_type Hash, :variables, allow_nil: true
      validates_type Array, :tags, allow_nil: true
      validates_length_range 0..1, :tags, allow_nil: true
    end

    def process
      require "mailgun-ruby"

      client =
        if !PUNK.env.test? && PUNK.get.mailgun.mock
          Mailgun::Client.new(PUNK.get.mailgun.api_key, "bin.mailgun.net", PUNK.get.mailgun.postbin, ssl=false) # rubocop:disable Lint/UselessAssignment,Layout/SpaceAroundOperators
        else
          Mailgun::Client.new(PUNK.get.mailgun.api_key)
        end

      client.enable_test_mode! if PUNK.env.test?

      message =
        {
          from: from,
          to: to,
          subject: subject,
          template: template
        }
      variables.each { |variable, value| message["v:#{variable}"] = value } if variables.present?
      tags.each { |tag| message["o:tag"] = tag } if tags.present?

      # TODO: store return value in Message table
      # TODO: update Message table with events from mailgun webhooks
      client.send_message(PUNK.get.mailgun.domain, message)

      return unless !PUNK.env.test? && PUNK.get.mailgun.mock

      require "launchy"
      Launchy.open("http://bin.mailgun.net/#{PUNK.get.mailgun.postbin}")
    end
  end
end
