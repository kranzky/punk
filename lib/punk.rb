# frozen_string_literal: true

require 'bootsnap'

env = ENV.fetch('PUNK_ENV') { ENV.store('PUNK_ENV', 'development') }

if defined?(Bootsnap)
  Bootsnap.setup(
    cache_dir: 'tmp/cache',
    development_mode: env == 'development',
    load_path_cache: true,
    autoload_paths_cache: true,
    disable_trace: false,
    compile_cache_iseq: true,
    compile_cache_yaml: true
  )
end

module PUNK
  def self.init(task: 'server', path: './app', config: {})
    require_relative 'punk/core/interface'
    raise InternalServerError, 'Cannot call PUNK.init multiple times!' if state != :included
    store.args = OpenStruct.new(
      task: task,
      path: path,
      config: config
    )
    store.state = :initialised
    Interface.bootstrap
    self
  end
end
