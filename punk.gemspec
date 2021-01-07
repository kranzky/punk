# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: punk 0.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "punk".freeze
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Lloyd Kranzky".freeze]
  s.date = "2021-01-07"
  s.description = "".freeze
  s.email = "lloyd@kranzky.com".freeze
  s.executables = ["punk".freeze]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "README.md",
    "Rakefile",
    "UNLICENSE",
    "VERSION",
    "bin/punk",
    "lib/punk.rb",
    "lib/punk/commands/auth.rb",
    "lib/punk/commands/generate.rb",
    "lib/punk/commands/http.rb",
    "lib/punk/commands/list.rb",
    "lib/punk/config/console/defaults.json",
    "lib/punk/config/defaults.json",
    "lib/punk/config/schema.json",
    "lib/punk/config/script/defaults.json",
    "lib/punk/config/server/development.json",
    "lib/punk/config/spec/defaults.json",
    "lib/punk/core/app.rb",
    "lib/punk/core/boot.rb",
    "lib/punk/core/cli.rb",
    "lib/punk/core/commander.rb",
    "lib/punk/core/commands.rb",
    "lib/punk/core/env.rb",
    "lib/punk/core/error.rb",
    "lib/punk/core/exec.rb",
    "lib/punk/core/interface.rb",
    "lib/punk/core/load.rb",
    "lib/punk/core/logger.rb",
    "lib/punk/core/monkey.rb",
    "lib/punk/core/monkey_unreloader.rb",
    "lib/punk/core/pry.rb",
    "lib/punk/core/settings.rb",
    "lib/punk/core/version.rb",
    "lib/punk/core/worker.rb",
    "lib/punk/framework/action.rb",
    "lib/punk/framework/all.rb",
    "lib/punk/framework/command.rb",
    "lib/punk/framework/model.rb",
    "lib/punk/framework/plugins/all.rb",
    "lib/punk/framework/plugins/validation.rb",
    "lib/punk/framework/runnable.rb",
    "lib/punk/framework/service.rb",
    "lib/punk/framework/view.rb",
    "lib/punk/framework/worker.rb",
    "lib/punk/helpers/all.rb",
    "lib/punk/helpers/loggable.rb",
    "lib/punk/helpers/publishable.rb",
    "lib/punk/helpers/renderable.rb",
    "lib/punk/helpers/swagger.rb",
    "lib/punk/helpers/validatable.rb",
    "lib/punk/plugins/all.rb",
    "lib/punk/plugins/cors.rb",
    "lib/punk/plugins/ssl.rb",
    "lib/punk/startup/cache.rb",
    "lib/punk/startup/database.rb",
    "lib/punk/startup/environment.rb",
    "lib/punk/startup/logger.rb",
    "lib/punk/startup/task.rb",
    "lib/punk/templates/fail.jbuilder",
    "lib/punk/templates/fail.rcsv",
    "lib/punk/templates/fail.slim",
    "lib/punk/templates/fail.xml.slim",
    "lib/punk/templates/info.jbuilder",
    "lib/punk/templates/info.rcsv",
    "lib/punk/templates/info.slim",
    "lib/punk/templates/info.xml.slim",
    "lib/punk/views/all.rb",
    "lib/punk/views/fail.rb",
    "lib/punk/views/info.rb",
    "punk.gemspec"
  ]
  s.homepage = "https://github.com/kranzky/punk".freeze
  s.licenses = ["UNLICENSE".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.6".freeze)
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Punk! is an omakase web framework for rapid prototyping.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bootsnap>.freeze, ["~> 1.5.1"])
      s.add_runtime_dependency(%q<dim>.freeze, ["~> 1.2.8"])
      s.add_runtime_dependency(%q<wisper>.freeze, ["~> 2.0.1"])
      s.add_runtime_dependency(%q<papertrail>.freeze, ["~> 0.11.0"])
      s.add_runtime_dependency(%q<semantic_logger>.freeze, ["~> 4.7.4"])
      s.add_runtime_dependency(%q<dotenv>.freeze, ["~> 2.7.6"])
      s.add_runtime_dependency(%q<dot_hash>.freeze, ["~> 1.1.8"])
      s.add_runtime_dependency(%q<commander>.freeze, ["~> 4.5.2"])
      s.add_runtime_dependency(%q<pry>.freeze, ["~> 0.13.1"])
      s.add_runtime_dependency(%q<puma>.freeze, ["~> 5.1.1"])
      s.add_runtime_dependency(%q<rack-cors>.freeze, ["~> 1.1.1"])
      s.add_runtime_dependency(%q<rack-protection>.freeze, ["~> 2.1.0"])
      s.add_runtime_dependency(%q<rack-ssl-enforcer>.freeze, ["~> 0.2.9"])
      s.add_runtime_dependency(%q<rack-unreloader>.freeze, ["~> 1.7.0"])
      s.add_runtime_dependency(%q<dalli>.freeze, ["~> 2.7.11"])
      s.add_runtime_dependency(%q<pg>.freeze, ["~> 1.2.3"])
      s.add_runtime_dependency(%q<sequel_pg>.freeze, ["~> 1.14.0"])
      s.add_runtime_dependency(%q<sequel>.freeze, ["~> 5.40.0"])
      s.add_runtime_dependency(%q<aasm>.freeze, ["~> 5.1.1"])
      s.add_runtime_dependency(%q<http-accept>.freeze, ["~> 2.1.1"])
      s.add_runtime_dependency(%q<maxmind-db>.freeze, ["~> 1.1.1"])
      s.add_runtime_dependency(%q<rbnacl>.freeze, ["~> 7.1.1"])
      s.add_runtime_dependency(%q<userstack>.freeze, ["~> 0.1.0"])
      s.add_runtime_dependency(%q<sidekiq>.freeze, ["~> 6.1.2"])
      s.add_runtime_dependency(%q<sidekiq-cron>.freeze, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<mailgun-ruby>.freeze, ["~> 1.2.0"])
      s.add_runtime_dependency(%q<plivo>.freeze, ["~> 4.15.1"])
      s.add_runtime_dependency(%q<roda>.freeze, ["~> 3.39.0"])
      s.add_runtime_dependency(%q<roda-route_list>.freeze, ["~> 2.1.0"])
      s.add_runtime_dependency(%q<slim>.freeze, ["~> 4.1.0"])
      s.add_runtime_dependency(%q<jbuilder>.freeze, ["~> 2.10.1"])
      s.add_runtime_dependency(%q<oj>.freeze, ["~> 3.10.18"])
      s.add_runtime_dependency(%q<tilt-jbuilder>.freeze, ["~> 0.7.1"])
      s.add_runtime_dependency(%q<rdoc>.freeze, ["~> 6.3.0"])
      s.add_runtime_dependency(%q<swagger_yard>.freeze, ["~> 1.0.4"])
      s.add_runtime_dependency(%q<activesupport>.freeze, ["~> 6.1.0"])
      s.add_runtime_dependency(%q<sentry-raven>.freeze, ["~> 3.1.1"])
      s.add_runtime_dependency(%q<skylight>.freeze, ["~> 4.3.2"])
      s.add_runtime_dependency(%q<phony>.freeze, ["~> 2.18.18"])
      s.add_development_dependency(%q<gemfile_updater>.freeze, ["~> 0.1.0"])
      s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.4.9"])
      s.add_development_dependency(%q<amazing_print>.freeze, ["~> 1.2.2"])
      s.add_development_dependency(%q<byebug>.freeze, ["~> 11.1.3"])
      s.add_development_dependency(%q<launchy>.freeze, ["~> 2.5.0"])
      s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 3.9.0"])
    else
      s.add_dependency(%q<bootsnap>.freeze, ["~> 1.5.1"])
      s.add_dependency(%q<dim>.freeze, ["~> 1.2.8"])
      s.add_dependency(%q<wisper>.freeze, ["~> 2.0.1"])
      s.add_dependency(%q<papertrail>.freeze, ["~> 0.11.0"])
      s.add_dependency(%q<semantic_logger>.freeze, ["~> 4.7.4"])
      s.add_dependency(%q<dotenv>.freeze, ["~> 2.7.6"])
      s.add_dependency(%q<dot_hash>.freeze, ["~> 1.1.8"])
      s.add_dependency(%q<commander>.freeze, ["~> 4.5.2"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.13.1"])
      s.add_dependency(%q<puma>.freeze, ["~> 5.1.1"])
      s.add_dependency(%q<rack-cors>.freeze, ["~> 1.1.1"])
      s.add_dependency(%q<rack-protection>.freeze, ["~> 2.1.0"])
      s.add_dependency(%q<rack-ssl-enforcer>.freeze, ["~> 0.2.9"])
      s.add_dependency(%q<rack-unreloader>.freeze, ["~> 1.7.0"])
      s.add_dependency(%q<dalli>.freeze, ["~> 2.7.11"])
      s.add_dependency(%q<pg>.freeze, ["~> 1.2.3"])
      s.add_dependency(%q<sequel_pg>.freeze, ["~> 1.14.0"])
      s.add_dependency(%q<sequel>.freeze, ["~> 5.40.0"])
      s.add_dependency(%q<aasm>.freeze, ["~> 5.1.1"])
      s.add_dependency(%q<http-accept>.freeze, ["~> 2.1.1"])
      s.add_dependency(%q<maxmind-db>.freeze, ["~> 1.1.1"])
      s.add_dependency(%q<rbnacl>.freeze, ["~> 7.1.1"])
      s.add_dependency(%q<userstack>.freeze, ["~> 0.1.0"])
      s.add_dependency(%q<sidekiq>.freeze, ["~> 6.1.2"])
      s.add_dependency(%q<sidekiq-cron>.freeze, ["~> 1.2.0"])
      s.add_dependency(%q<mailgun-ruby>.freeze, ["~> 1.2.0"])
      s.add_dependency(%q<plivo>.freeze, ["~> 4.15.1"])
      s.add_dependency(%q<roda>.freeze, ["~> 3.39.0"])
      s.add_dependency(%q<roda-route_list>.freeze, ["~> 2.1.0"])
      s.add_dependency(%q<slim>.freeze, ["~> 4.1.0"])
      s.add_dependency(%q<jbuilder>.freeze, ["~> 2.10.1"])
      s.add_dependency(%q<oj>.freeze, ["~> 3.10.18"])
      s.add_dependency(%q<tilt-jbuilder>.freeze, ["~> 0.7.1"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 6.3.0"])
      s.add_dependency(%q<swagger_yard>.freeze, ["~> 1.0.4"])
      s.add_dependency(%q<activesupport>.freeze, ["~> 6.1.0"])
      s.add_dependency(%q<sentry-raven>.freeze, ["~> 3.1.1"])
      s.add_dependency(%q<skylight>.freeze, ["~> 4.3.2"])
      s.add_dependency(%q<phony>.freeze, ["~> 2.18.18"])
      s.add_dependency(%q<gemfile_updater>.freeze, ["~> 0.1.0"])
      s.add_dependency(%q<juwelier>.freeze, ["~> 2.4.9"])
      s.add_dependency(%q<amazing_print>.freeze, ["~> 1.2.2"])
      s.add_dependency(%q<byebug>.freeze, ["~> 11.1.3"])
      s.add_dependency(%q<launchy>.freeze, ["~> 2.5.0"])
      s.add_dependency(%q<pry-byebug>.freeze, ["~> 3.9.0"])
    end
  else
    s.add_dependency(%q<bootsnap>.freeze, ["~> 1.5.1"])
    s.add_dependency(%q<dim>.freeze, ["~> 1.2.8"])
    s.add_dependency(%q<wisper>.freeze, ["~> 2.0.1"])
    s.add_dependency(%q<papertrail>.freeze, ["~> 0.11.0"])
    s.add_dependency(%q<semantic_logger>.freeze, ["~> 4.7.4"])
    s.add_dependency(%q<dotenv>.freeze, ["~> 2.7.6"])
    s.add_dependency(%q<dot_hash>.freeze, ["~> 1.1.8"])
    s.add_dependency(%q<commander>.freeze, ["~> 4.5.2"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.13.1"])
    s.add_dependency(%q<puma>.freeze, ["~> 5.1.1"])
    s.add_dependency(%q<rack-cors>.freeze, ["~> 1.1.1"])
    s.add_dependency(%q<rack-protection>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<rack-ssl-enforcer>.freeze, ["~> 0.2.9"])
    s.add_dependency(%q<rack-unreloader>.freeze, ["~> 1.7.0"])
    s.add_dependency(%q<dalli>.freeze, ["~> 2.7.11"])
    s.add_dependency(%q<pg>.freeze, ["~> 1.2.3"])
    s.add_dependency(%q<sequel_pg>.freeze, ["~> 1.14.0"])
    s.add_dependency(%q<sequel>.freeze, ["~> 5.40.0"])
    s.add_dependency(%q<aasm>.freeze, ["~> 5.1.1"])
    s.add_dependency(%q<http-accept>.freeze, ["~> 2.1.1"])
    s.add_dependency(%q<maxmind-db>.freeze, ["~> 1.1.1"])
    s.add_dependency(%q<rbnacl>.freeze, ["~> 7.1.1"])
    s.add_dependency(%q<userstack>.freeze, ["~> 0.1.0"])
    s.add_dependency(%q<sidekiq>.freeze, ["~> 6.1.2"])
    s.add_dependency(%q<sidekiq-cron>.freeze, ["~> 1.2.0"])
    s.add_dependency(%q<mailgun-ruby>.freeze, ["~> 1.2.0"])
    s.add_dependency(%q<plivo>.freeze, ["~> 4.15.1"])
    s.add_dependency(%q<roda>.freeze, ["~> 3.39.0"])
    s.add_dependency(%q<roda-route_list>.freeze, ["~> 2.1.0"])
    s.add_dependency(%q<slim>.freeze, ["~> 4.1.0"])
    s.add_dependency(%q<jbuilder>.freeze, ["~> 2.10.1"])
    s.add_dependency(%q<oj>.freeze, ["~> 3.10.18"])
    s.add_dependency(%q<tilt-jbuilder>.freeze, ["~> 0.7.1"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 6.3.0"])
    s.add_dependency(%q<swagger_yard>.freeze, ["~> 1.0.4"])
    s.add_dependency(%q<activesupport>.freeze, ["~> 6.1.0"])
    s.add_dependency(%q<sentry-raven>.freeze, ["~> 3.1.1"])
    s.add_dependency(%q<skylight>.freeze, ["~> 4.3.2"])
    s.add_dependency(%q<phony>.freeze, ["~> 2.18.18"])
    s.add_dependency(%q<gemfile_updater>.freeze, ["~> 0.1.0"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.4.9"])
    s.add_dependency(%q<amazing_print>.freeze, ["~> 1.2.2"])
    s.add_dependency(%q<byebug>.freeze, ["~> 11.1.3"])
    s.add_dependency(%q<launchy>.freeze, ["~> 2.5.0"])
    s.add_dependency(%q<pry-byebug>.freeze, ["~> 3.9.0"])
  end
end

