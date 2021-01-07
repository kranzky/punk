# frozen_string_literal: true

def perform(action_class, **kwargs)
  raise PUNK::InternalServerError, "Not an action: #{action_class}" unless action_class < PUNK::Action
  action_class.perform(**kwargs)
ensure
  SemanticLogger.flush
end

def present(view_class, **kwargs)
  raise PUNK::InternalServerError, "Not a view: #{view_class}" unless view_class < PUNK::View
  view_class.present(**kwargs)
ensure
  SemanticLogger.flush
end

def run(service_class, **kwargs)
  raise PUNK::InternalServerError, "Not a service: #{service_class}" unless service_class.superclass == PUNK::Service
  service_class.run(**kwargs).result
ensure
  SemanticLogger.flush
end

def reload!
  ['actions', 'models', 'views', 'services', 'workers'].each do |dir|
    path = File.join(PUNK.get.app.path, dir)
    Dir.glob(File.join(path, '**/*.rb')).each { |file| load(file) }
  end
  "Reloaded all actions, models, views, services and workers."
ensure
  SemanticLogger.flush
end

Pry.config.print =
  proc do |output, value|
    SemanticLogger.flush
    output.puts "=> #{value.inspect}"
  end
Pry.config.prompt_name = "🍰 "
