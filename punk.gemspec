# Generated by juwelier
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Juwelier::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: punk 0.3.6 ruby lib

Gem::Specification.new do |s|
  s.name = "punk".freeze
  s.version = "0.3.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Lloyd Kranzky".freeze]
  s.date = "2021-03-02"
  s.description = "".freeze
  s.email = "lloyd@kranzky.com".freeze
  s.executables = ["punk".freeze]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".document",
    ".editorconfig",
    ".github/workflows/ship.yml",
    ".github/workflows/test.yml",
    ".rdoc_options",
    ".rgignore",
    ".rspec",
    ".rubocop.yml",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "app/migrations/001_lets_punk.rb",
    "app/routes/hello.rb",
    "bin/punk",
    "env/.gitignore",
    "env/defaults.sh",
    "env/spec/test.sh",
    "env/test.sh",
    "lib/punk.rb",
    "lib/punk/actions/.keep",
    "lib/punk/actions/groups/list.rb",
    "lib/punk/actions/sessions/clear.rb",
    "lib/punk/actions/sessions/create.rb",
    "lib/punk/actions/sessions/list.rb",
    "lib/punk/actions/sessions/verify.rb",
    "lib/punk/actions/tenants/list.rb",
    "lib/punk/actions/users/list_group.rb",
    "lib/punk/actions/users/list_tenant.rb",
    "lib/punk/actions/users/show.rb",
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
    "lib/punk/migrations/001_punk.rb",
    "lib/punk/models/.keep",
    "lib/punk/models/group.rb",
    "lib/punk/models/group_user_metadata.rb",
    "lib/punk/models/identity.rb",
    "lib/punk/models/session.rb",
    "lib/punk/models/tenant.rb",
    "lib/punk/models/tenant_user_metadata.rb",
    "lib/punk/models/user.rb",
    "lib/punk/plugins/all.rb",
    "lib/punk/plugins/cors.rb",
    "lib/punk/plugins/ssl.rb",
    "lib/punk/routes/groups.rb",
    "lib/punk/routes/plivo.rb",
    "lib/punk/routes/sessions.rb",
    "lib/punk/routes/swagger.rb",
    "lib/punk/routes/tenants.rb",
    "lib/punk/routes/users.rb",
    "lib/punk/services/.keep",
    "lib/punk/services/challenge_claim.rb",
    "lib/punk/services/create_identities.rb",
    "lib/punk/services/generate_swagger.rb",
    "lib/punk/services/prove_claim.rb",
    "lib/punk/services/secret.rb",
    "lib/punk/startup/cache.rb",
    "lib/punk/startup/database.rb",
    "lib/punk/startup/environment.rb",
    "lib/punk/startup/logger.rb",
    "lib/punk/startup/task.rb",
    "lib/punk/templates/fail.jbuilder",
    "lib/punk/templates/fail.rcsv",
    "lib/punk/templates/fail.slim",
    "lib/punk/templates/fail.xml.slim",
    "lib/punk/templates/groups/list.jbuilder",
    "lib/punk/templates/info.jbuilder",
    "lib/punk/templates/info.rcsv",
    "lib/punk/templates/info.slim",
    "lib/punk/templates/info.xml.slim",
    "lib/punk/templates/plivo.slim",
    "lib/punk/templates/sessions/list.jbuilder",
    "lib/punk/templates/sessions/pending.jbuilder",
    "lib/punk/templates/tenants/list.jbuilder",
    "lib/punk/templates/tenants/list.slim",
    "lib/punk/templates/users/list.jbuilder",
    "lib/punk/templates/users/list.rcsv",
    "lib/punk/templates/users/show.jbuilder",
    "lib/punk/views/fail.rb",
    "lib/punk/views/groups/list.rb",
    "lib/punk/views/info.rb",
    "lib/punk/views/plivo_store.rb",
    "lib/punk/views/sessions/list.rb",
    "lib/punk/views/sessions/pending.rb",
    "lib/punk/views/tenants/list.rb",
    "lib/punk/views/users/list.rb",
    "lib/punk/views/users/show.rb",
    "lib/punk/workers/.keep",
    "lib/punk/workers/expire_sessions.rb",
    "lib/punk/workers/geocode_session_worker.rb",
    "lib/punk/workers/identify_session_worker.rb",
    "lib/punk/workers/secret.rb",
    "lib/punk/workers/send_email_worker.rb",
    "lib/punk/workers/send_sms_worker.rb",
    "punk.gemspec",
    "schema.psql",
    "spec/actions/groups/punk/list_groups_action_spec.rb",
    "spec/actions/sessions/punk/clear_session_action_spec.rb",
    "spec/actions/sessions/punk/create_session_action_spec.rb",
    "spec/actions/sessions/punk/list_sessions_action_spec.rb",
    "spec/actions/sessions/punk/verify_session_action_spec.rb",
    "spec/actions/tenants/punk/list_tenants_action_spec.rb",
    "spec/actions/users/punk/list_group_users_action_spec.rb",
    "spec/actions/users/punk/list_tenant_users_action_spec.rb",
    "spec/factories/group.rb",
    "spec/factories/group_user_metadata.rb",
    "spec/factories/identity.rb",
    "spec/factories/session.rb",
    "spec/factories/tenant.rb",
    "spec/factories/tenant_user_metadata.rb",
    "spec/factories/user.rb",
    "spec/lib/commands/auth_spec.rb",
    "spec/lib/commands/generate_spec.rb",
    "spec/lib/commands/http_spec.rb",
    "spec/lib/commands/list_spec.rb",
    "spec/lib/commands/swagger_spec.rb",
    "spec/lib/engine/punk_env_spec.rb",
    "spec/lib/engine/punk_exec_spec.rb",
    "spec/lib/engine/punk_init_spec.rb",
    "spec/lib/engine/punk_store_spec.rb",
    "spec/lib/punk.env",
    "spec/models/punk/group_spec.rb",
    "spec/models/punk/group_user_metadata_spec.rb",
    "spec/models/punk/identity_spec.rb",
    "spec/models/punk/session_spec.rb",
    "spec/models/punk/tenant_spec.rb",
    "spec/models/punk/tenant_user_metadata_spec.rb",
    "spec/models/punk/user_spec.rb",
    "spec/routes/groups/get_groups_spec.rb",
    "spec/routes/plivo/get_plivo_spec.rb",
    "spec/routes/sessions/delete_session_spec.rb",
    "spec/routes/sessions/get_sessions_spec.rb",
    "spec/routes/sessions/patch_session_spec.rb",
    "spec/routes/sessions/post_session_spec.rb",
    "spec/routes/swagger/get_swagger_spec.rb",
    "spec/routes/tenants/get_tenants_spec.rb",
    "spec/routes/users/get_users_spec.rb",
    "spec/services/punk/challenge_claim_service_spec.rb",
    "spec/services/punk/create_identities_service_spec.rb",
    "spec/services/punk/generate_swagger_service_spec.rb",
    "spec/services/punk/prove_claim_service_spec.rb",
    "spec/services/punk/secret_service_spec.rb",
    "spec/spec_helper.rb",
    "spec/vcr_cassettes/PUNK_GeocodeSessionWorker/updates_the_session_data.yml",
    "spec/vcr_cassettes/PUNK_IdentifySessionWorker/updates_the_session_data.yml",
    "spec/views/punk/plivo_store_spec.rb",
    "spec/views/sessions/punk/list_sessions_view_spec.rb",
    "spec/views/sessions/punk/pending_session_view_spec.rb",
    "spec/views/tenants/punk/list_tenants_view_spec.rb",
    "spec/views/users/punk/list_groups_view_spec.rb",
    "spec/views/users/punk/list_users_view_spec.rb",
    "spec/workers/punk/expire_sessions_worker_spec.rb",
    "spec/workers/punk/geocode_session_worker_spec.rb",
    "spec/workers/punk/identify_session_worker_spec.rb",
    "spec/workers/punk/secret_worker_spec.rb",
    "spec/workers/punk/send_email_worker_spec.rb",
    "spec/workers/punk/send_sms_worker_spec.rb"
  ]
  s.homepage = "https://github.com/kranzky/punk".freeze
  s.licenses = ["Unlicense".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.1".freeze)
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Punk! is an omakase web framework for rapid prototyping.".freeze

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<bootsnap>.freeze, ["~> 1.7"])
      s.add_runtime_dependency(%q<dim>.freeze, ["~> 1.2"])
      s.add_runtime_dependency(%q<wisper>.freeze, ["~> 2.0"])
      s.add_runtime_dependency(%q<papertrail>.freeze, ["~> 0.11"])
      s.add_runtime_dependency(%q<semantic_logger>.freeze, ["~> 4.7"])
      s.add_runtime_dependency(%q<dotenv>.freeze, ["~> 2.7"])
      s.add_runtime_dependency(%q<dot_hash>.freeze, ["~> 1.1"])
      s.add_runtime_dependency(%q<commander>.freeze, ["~> 4.5"])
      s.add_runtime_dependency(%q<pry>.freeze, ["~> 0.14"])
      s.add_runtime_dependency(%q<puma>.freeze, ["~> 5.2"])
      s.add_runtime_dependency(%q<rack-cors>.freeze, ["~> 1.1"])
      s.add_runtime_dependency(%q<rack-protection>.freeze, ["~> 2.1"])
      s.add_runtime_dependency(%q<rack-ssl-enforcer>.freeze, ["~> 0.2"])
      s.add_runtime_dependency(%q<rack-unreloader>.freeze, ["~> 1.7"])
      s.add_runtime_dependency(%q<dalli>.freeze, ["~> 2.7"])
      s.add_runtime_dependency(%q<pg>.freeze, ["~> 1.2"])
      s.add_runtime_dependency(%q<sequel_pg>.freeze, ["~> 1.14"])
      s.add_runtime_dependency(%q<sequel>.freeze, ["~> 5.42"])
      s.add_runtime_dependency(%q<aasm>.freeze, ["~> 5.1"])
      s.add_runtime_dependency(%q<http-accept>.freeze, ["~> 2.1"])
      s.add_runtime_dependency(%q<ipstack>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<rbnacl>.freeze, ["~> 7.1"])
      s.add_runtime_dependency(%q<userstack>.freeze, ["~> 0.1"])
      s.add_runtime_dependency(%q<sidekiq>.freeze, ["~> 6.1"])
      s.add_runtime_dependency(%q<sidekiq-cron>.freeze, ["~> 1.2"])
      s.add_runtime_dependency(%q<mailgun-ruby>.freeze, ["~> 1.2"])
      s.add_runtime_dependency(%q<plivo>.freeze, ["~> 4.16"])
      s.add_runtime_dependency(%q<roda>.freeze, ["~> 3.41"])
      s.add_runtime_dependency(%q<roda-route_list>.freeze, ["~> 2.1"])
      s.add_runtime_dependency(%q<slim>.freeze, ["~> 4.1"])
      s.add_runtime_dependency(%q<jbuilder>.freeze, ["~> 2.11"])
      s.add_runtime_dependency(%q<oj>.freeze, ["~> 3.11"])
      s.add_runtime_dependency(%q<tilt-jbuilder>.freeze, ["~> 0.7"])
      s.add_runtime_dependency(%q<rdoc>.freeze, ["~> 6.3"])
      s.add_runtime_dependency(%q<swagger_yard>.freeze, ["~> 1.0"])
      s.add_runtime_dependency(%q<activesupport>.freeze, ["~> 6.1"])
      s.add_runtime_dependency(%q<sentry-ruby>.freeze, ["~> 4.2"])
      s.add_runtime_dependency(%q<sentry-sidekiq>.freeze, ["~> 4.2"])
      s.add_runtime_dependency(%q<skylight>.freeze, ["~> 4.3"])
      s.add_runtime_dependency(%q<phony>.freeze, ["~> 2.18"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.17"])
      s.add_development_dependency(%q<gemfile_updater>.freeze, ["~> 0.1"])
      s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.4"])
      s.add_development_dependency(%q<amazing_print>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<byebug>.freeze, ["~> 11.1"])
      s.add_development_dependency(%q<launchy>.freeze, ["~> 2.5"])
    else
      s.add_dependency(%q<bootsnap>.freeze, ["~> 1.7"])
      s.add_dependency(%q<dim>.freeze, ["~> 1.2"])
      s.add_dependency(%q<wisper>.freeze, ["~> 2.0"])
      s.add_dependency(%q<papertrail>.freeze, ["~> 0.11"])
      s.add_dependency(%q<semantic_logger>.freeze, ["~> 4.7"])
      s.add_dependency(%q<dotenv>.freeze, ["~> 2.7"])
      s.add_dependency(%q<dot_hash>.freeze, ["~> 1.1"])
      s.add_dependency(%q<commander>.freeze, ["~> 4.5"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.14"])
      s.add_dependency(%q<puma>.freeze, ["~> 5.2"])
      s.add_dependency(%q<rack-cors>.freeze, ["~> 1.1"])
      s.add_dependency(%q<rack-protection>.freeze, ["~> 2.1"])
      s.add_dependency(%q<rack-ssl-enforcer>.freeze, ["~> 0.2"])
      s.add_dependency(%q<rack-unreloader>.freeze, ["~> 1.7"])
      s.add_dependency(%q<dalli>.freeze, ["~> 2.7"])
      s.add_dependency(%q<pg>.freeze, ["~> 1.2"])
      s.add_dependency(%q<sequel_pg>.freeze, ["~> 1.14"])
      s.add_dependency(%q<sequel>.freeze, ["~> 5.42"])
      s.add_dependency(%q<aasm>.freeze, ["~> 5.1"])
      s.add_dependency(%q<http-accept>.freeze, ["~> 2.1"])
      s.add_dependency(%q<ipstack>.freeze, ["~> 0.1"])
      s.add_dependency(%q<rbnacl>.freeze, ["~> 7.1"])
      s.add_dependency(%q<userstack>.freeze, ["~> 0.1"])
      s.add_dependency(%q<sidekiq>.freeze, ["~> 6.1"])
      s.add_dependency(%q<sidekiq-cron>.freeze, ["~> 1.2"])
      s.add_dependency(%q<mailgun-ruby>.freeze, ["~> 1.2"])
      s.add_dependency(%q<plivo>.freeze, ["~> 4.16"])
      s.add_dependency(%q<roda>.freeze, ["~> 3.41"])
      s.add_dependency(%q<roda-route_list>.freeze, ["~> 2.1"])
      s.add_dependency(%q<slim>.freeze, ["~> 4.1"])
      s.add_dependency(%q<jbuilder>.freeze, ["~> 2.11"])
      s.add_dependency(%q<oj>.freeze, ["~> 3.11"])
      s.add_dependency(%q<tilt-jbuilder>.freeze, ["~> 0.7"])
      s.add_dependency(%q<rdoc>.freeze, ["~> 6.3"])
      s.add_dependency(%q<swagger_yard>.freeze, ["~> 1.0"])
      s.add_dependency(%q<activesupport>.freeze, ["~> 6.1"])
      s.add_dependency(%q<sentry-ruby>.freeze, ["~> 4.2"])
      s.add_dependency(%q<sentry-sidekiq>.freeze, ["~> 4.2"])
      s.add_dependency(%q<skylight>.freeze, ["~> 4.3"])
      s.add_dependency(%q<phony>.freeze, ["~> 2.18"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.17"])
      s.add_dependency(%q<gemfile_updater>.freeze, ["~> 0.1"])
      s.add_dependency(%q<juwelier>.freeze, ["~> 2.4"])
      s.add_dependency(%q<amazing_print>.freeze, ["~> 1.2"])
      s.add_dependency(%q<byebug>.freeze, ["~> 11.1"])
      s.add_dependency(%q<launchy>.freeze, ["~> 2.5"])
    end
  else
    s.add_dependency(%q<bootsnap>.freeze, ["~> 1.7"])
    s.add_dependency(%q<dim>.freeze, ["~> 1.2"])
    s.add_dependency(%q<wisper>.freeze, ["~> 2.0"])
    s.add_dependency(%q<papertrail>.freeze, ["~> 0.11"])
    s.add_dependency(%q<semantic_logger>.freeze, ["~> 4.7"])
    s.add_dependency(%q<dotenv>.freeze, ["~> 2.7"])
    s.add_dependency(%q<dot_hash>.freeze, ["~> 1.1"])
    s.add_dependency(%q<commander>.freeze, ["~> 4.5"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.14"])
    s.add_dependency(%q<puma>.freeze, ["~> 5.2"])
    s.add_dependency(%q<rack-cors>.freeze, ["~> 1.1"])
    s.add_dependency(%q<rack-protection>.freeze, ["~> 2.1"])
    s.add_dependency(%q<rack-ssl-enforcer>.freeze, ["~> 0.2"])
    s.add_dependency(%q<rack-unreloader>.freeze, ["~> 1.7"])
    s.add_dependency(%q<dalli>.freeze, ["~> 2.7"])
    s.add_dependency(%q<pg>.freeze, ["~> 1.2"])
    s.add_dependency(%q<sequel_pg>.freeze, ["~> 1.14"])
    s.add_dependency(%q<sequel>.freeze, ["~> 5.42"])
    s.add_dependency(%q<aasm>.freeze, ["~> 5.1"])
    s.add_dependency(%q<http-accept>.freeze, ["~> 2.1"])
    s.add_dependency(%q<ipstack>.freeze, ["~> 0.1"])
    s.add_dependency(%q<rbnacl>.freeze, ["~> 7.1"])
    s.add_dependency(%q<userstack>.freeze, ["~> 0.1"])
    s.add_dependency(%q<sidekiq>.freeze, ["~> 6.1"])
    s.add_dependency(%q<sidekiq-cron>.freeze, ["~> 1.2"])
    s.add_dependency(%q<mailgun-ruby>.freeze, ["~> 1.2"])
    s.add_dependency(%q<plivo>.freeze, ["~> 4.16"])
    s.add_dependency(%q<roda>.freeze, ["~> 3.41"])
    s.add_dependency(%q<roda-route_list>.freeze, ["~> 2.1"])
    s.add_dependency(%q<slim>.freeze, ["~> 4.1"])
    s.add_dependency(%q<jbuilder>.freeze, ["~> 2.11"])
    s.add_dependency(%q<oj>.freeze, ["~> 3.11"])
    s.add_dependency(%q<tilt-jbuilder>.freeze, ["~> 0.7"])
    s.add_dependency(%q<rdoc>.freeze, ["~> 6.3"])
    s.add_dependency(%q<swagger_yard>.freeze, ["~> 1.0"])
    s.add_dependency(%q<activesupport>.freeze, ["~> 6.1"])
    s.add_dependency(%q<sentry-ruby>.freeze, ["~> 4.2"])
    s.add_dependency(%q<sentry-sidekiq>.freeze, ["~> 4.2"])
    s.add_dependency(%q<skylight>.freeze, ["~> 4.3"])
    s.add_dependency(%q<phony>.freeze, ["~> 2.18"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.17"])
    s.add_dependency(%q<gemfile_updater>.freeze, ["~> 0.1"])
    s.add_dependency(%q<juwelier>.freeze, ["~> 2.4"])
    s.add_dependency(%q<amazing_print>.freeze, ["~> 1.2"])
    s.add_dependency(%q<byebug>.freeze, ["~> 11.1"])
    s.add_dependency(%q<launchy>.freeze, ["~> 2.5"])
  end
end

