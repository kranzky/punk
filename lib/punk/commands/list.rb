# frozen_string_literal: true

PUNK::Command.create "list" do
  shortcut 'l'
  description "List routes, actions, models, views, services or workers"

  option shortcut: :a, name: :all, description: "Include Punk!", type: nil

  def process
    case args.join(' ')
    when 'routes'
      PUNK.app
      PUNK::App.route_list # TODO: exclude PUNK routes by default
    when 'actions'
      ObjectSpace.each_object(PUNK::Action.singleton_class).map(&:name).reject { |name| _hide?(name) }
    when 'models'
      ObjectSpace.each_object(PUNK::Model.singleton_class).map(&:name).reject { |name| _hide?(name) }
    when 'views'
      ObjectSpace.each_object(PUNK::View.singleton_class).map(&:name).reject { |name| _hide?(name) }
    when 'services'
      ObjectSpace.each_object(PUNK::Service.singleton_class).select { |klass| klass.superclass == PUNK::Service }.map(&:name).reject { |name| _hide?(name) }
    when 'workers'
      ObjectSpace.each_object(PUNK::Worker.singleton_class).select { |klass| klass.superclass == PUNK::Worker }.map(&:name).reject { |name| _hide?(name) }
    when '', 'help'
      "? specify one of: routes, actions, models, views, services, workers"
    else
      "? unkown arguments: #{args.join(',')}"
    end
  end

  def _hide?(name)
    name.nil? || (name =~ /^PUNK/) && !opts[:all]
  end
end
