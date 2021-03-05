# frozen_string_literal: true

module PUNK
  class GenerateSwaggerService < Service
    def process
      path = File.join(PUNK.get.app.path, "..", "www", "swagger.json")
      raise InternalServerError, "swagger.json already exists" if File.exist?(path) && !PUNK.env.test?
      require "swagger_yard"
      require_relative "../helpers/swagger"
      SwaggerYard.register_custom_yard_tags!
      SwaggerYard.configure do |config|
        config.api_version = PUNK.version
        config.title = PUNK.get.app.name
        config.description = PUNK.get.app.description
        config.api_base_path = PUNK.get.app.url
        config.controller_path = [File.join(PUNK.get.app.path, "routes", "**", "*"), File.join(__dir__, "..", "routes", "**", "*")]
        config.model_path = [File.join(__dir__, "..", "models", "**", "*"), File.join(__dir__, "..", "views", "**", "*"), File.join(PUNK.get.app.path, "models", "**", "*")]
      end
      spec = SwaggerYard::OpenAPI.new
      blob = JSON.pretty_generate(spec.to_h)
      File.open(path, "w") { |f| f << blob } unless PUNK.env.test?
      blob
    end
  end
end
