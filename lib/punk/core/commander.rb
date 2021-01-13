# frozen_string_literal: true

command :test do |c|
  c.description = 'Run rubocop and rspec'
  c.action do
    say('Running tests...')
    unless ENV['PUNK_ENV'] == 'test'
      error('!!! PUNK_ENV should be test !!!')
      exit 1 # rubocop:disable Rails/Exit
    end
    ENV.delete_if { |name, _value| name =~ /^PUNK_/ }
    system('rubocop') &&
      system('quasar build -m pwa') &&
      system('PUNK_ENV=test rspec')
    exit $CHILD_STATUS.exitstatus # rubocop:disable Rails/Exit
  end
end

command :console do |c|
  c.description = 'Launch the console'
  c.action do
    say(HighLine.color('🤘 Are you ready to rock?', :green, :bold))
    path = File.join(__dir__, 'cli.rb')
    exec "pry -r #{path}"
  end
end
alias_command :c, :console

command :server do |c|
  c.description = 'Start the server'
  c.action do
    say('Starting server...')
    exec 'puma -C ./config/puma.rb'
  end
end
alias_command :s, :server

command :worker do |c|
  c.description = 'Start the worker'
  c.action do
    say('Starting worker...')
    path = File.join(__dir__, 'worker.rb')
    exec "sidekiq -r #{path} -C ./config/sidekiq.yml"
  end
end
alias_command :w, :worker

command 'env dump' do |c|
  c.description = 'Display the environment'
  c.action do
    say('Dumping env...')
    ap PUNK.get # rubocop:disable Rails/Output
  end
end

command 'db create' do |c|
  c.description = 'Create the database (dropping it first if necessary)'
  c.action do
    say('Creating db...')
    require 'sequel'
    database = File.basename(PUNK.get.db.url)
    server = PUNK.get.db.url.gsub(/[^\/]+$/, 'postgres')
    pg = Sequel.connect(server)
    pg.execute "DROP DATABASE IF EXISTS #{database}"
    pg.execute "CREATE DATABASE #{database}"
    pg.disconnect
  end
end

command 'db migrate' do |c|
  c.description = 'Run database migrations'
  c.option '-r', 'Number of versions to migrate, +ve for up and -ve for down', '--relative NUMBER', Integer
  c.action do |_args, options|
    say('Migrating db...')
    PUNK.boot
    Sequel.extension :migration
    migrations_path = File.join(PUNK.get.app.path, 'migrations')
    if File.exist?(migrations_path)
      if options.relative.nil?
        Sequel::Migrator.run(PUNK.db, migrations_path)
      else
        Sequel::Migrator.run(PUNK.db, migrations_path, relative: options.relative)
      end
    end
    if PUNK.env.development?
      database = File.basename(PUNK.get.db.url)
      `pg_dump #{database} --schema-only > schema.psql`
    end
  end
end
