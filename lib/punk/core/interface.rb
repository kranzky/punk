# frozen_string_literal: true

require 'active_support/dependencies/autoload'
require 'active_support/core_ext'
require 'active_support/json'

require 'oj'
Oj.optimize_rails

require 'forwardable'
require 'dim'

require_relative 'version'
require_relative 'error'
require_relative 'monkey'

module PUNK
  extend SingleForwardable

  def_single_delegators :store, :state

  def self.inject(*methods)
    def_single_delegators :'PUNK::Interface', *methods
  end

  Interface = Dim::Container.new
end

PUNK::Interface.register(:store) do
  require 'ostruct'
  store = OpenStruct.new
  store.state = :included
  Thread.current[:rr] = store
end

PUNK::Interface.register(:bootstrap) do
  raise PUNK::InternalServerError, 'Must call PUNK.init first!' if PUNK.state != :initialised
  require_relative 'settings'
  require_relative 'logger'
end

PUNK::Interface.register(:config) do |c|
  c.bootstrap
  PUNK.profile_trace('config') do
    require_relative 'env'
    PUNK.get.load!
    require_relative 'commands'
  end
end

PUNK::Interface.register(:boot) do |c|
  c.config
  retval = PUNK.profile_trace('boot') { require_relative 'boot' }
  PUNK.logger.info "Punk! v#{PUNK.version}"
  PUNK.db.fetch("SELECT version(), timeofday()") do |row|
    row.each_value { |value| PUNK.logger.info value }
  end
  retval
end

PUNK::Interface.register(:load) do |c|
  c.boot
  PUNK.profile_debug('load') { require_relative 'load' }
end

PUNK::Interface.register(:exec) do |c|
  c.load
  retval = PUNK.profile_debug('exec') { require_relative 'exec' }
  PUNK.logger.tagged(PUNK.env, PUNK.task) do
    PUNK.logger.info "☕ ☕ ☕  #{PUNK.get.app.name} ☕ ☕ ☕ "
  end
  SemanticLogger.flush
  retval
end

PUNK.inject :store, :config, :boot, :load, :exec
