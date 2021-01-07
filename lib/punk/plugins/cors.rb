# frozen_string_literal: true

class Roda
  module RodaPlugins
    module Cors
      def self.configure(app, origin)
        return if origin.nil?
        require 'rack/cors'
        app.use ::Rack::Cors do
          allow do
            origins origin
            resource '*', headers: :any, methods: :any
          end
        end
      end
    end
    register_plugin(:cors, Cors)
  end
end
