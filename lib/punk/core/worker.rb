# frozen_string_literal: true

require_relative '../../punk'
require 'sidekiq'
require 'sidekiq-cron'

PUNK.init(task: 'worker', config: { app: { name: 'Roadie' } }).exec

Sidekiq.logger = SemanticLogger['PUNK::SKQ']
Sidekiq.logger.class.alias_method(:with_context, :tagged)

path = File.expand_path(File.join(PUNK.get.app.path, '..', 'config', 'schedule.yml'))
Sidekiq::Cron::Job.load_from_hash(YAML.load_file(path))
