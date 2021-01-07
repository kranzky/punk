# frozen_string_literal: true

module PUNK
  def self.require_all(path)
    path = File.expand_path(path)
    PUNK.profile_debug("require_all", path: path) do
      if PUNK.get.app.reloadable?
        PUNK.loader.require(path)
      else
        Dir.glob(File.join(path, '**/*.rb')).sort.each { |file| require(file) }
      end
    end
  end
end

PUNK::Interface.register(:loader) do
  require 'rack/unreloader'
  raise PUNK::InternalServerError, "App is not reloadable" unless PUNK.get.app.reloadable?
  retval = Rack::Unreloader.new { PUNK::App }
  require_relative './monkey_unreloader'
  retval
end

PUNK::Interface.register(:app) do
  require_relative 'app'
  PUNK.require_all(File.join(PUNK.get.app.path, 'routes'))
  retval = PUNK.get.app.reloadable ? PUNK.loader : PUNK::App.freeze.app
  SemanticLogger.flush
  retval
end

PUNK.inject :loader, :app

['actions', 'models', 'views', 'services', 'workers'].each do |dir|
  PUNK.require_all(File.join(PUNK.get.app.path, dir))
end

PUNK.store[:state] = :started
