# frozen_string_literal: true

class Roda
  module RodaPlugins
    module Ssl
      def self.configure(app)
        require "rack/ssl-enforcer"
        app.use ::Rack::SslEnforcer
      end
    end
    register_plugin(:ssl, Ssl)
  end
end
