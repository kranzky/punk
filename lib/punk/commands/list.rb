# frozen_string_literal: true

PUNK::Command.create "list" do
  shortcut 'l'
  description "List routes, actions, models, views, services or workers"

  def process
    case args.join(' ')
    when 'routes'
      PUNK.app
      PUNK::App.route_list
    when 'actions'
      ObjectSpace.each_object(PUNK::Action.singleton_class).map(&:name).reject { |name| name.nil? || name =~ /^PUNK/ }
    when 'models'
      ObjectSpace.each_object(PUNK::Model.singleton_class).map(&:name).reject { |name| name.nil? || name =~ /^PUNK/ }
    when 'views'
      ObjectSpace.each_object(PUNK::View.singleton_class).map(&:name).reject { |name| name.nil? || name =~ /^PUNK/ }
    when 'services'
      ObjectSpace.each_object(PUNK::Service.singleton_class).select { |klass| klass.superclass == PUNK::Service }.map(&:name).reject { |name| name.nil? || name =~ /^PUNK/ }
    when 'workers'
      ObjectSpace.each_object(PUNK::Worker.singleton_class).select { |klass| klass.superclass == PUNK::Worker }.map(&:name).reject { |name| name.nil? || name =~ /^PUNK/ }
    when '', 'help'
      "? specify one of: routes, actions, models, views, services, workers"
    else
      "? unkown arguments: #{args.join(',')}"
    end
  end
end
