# frozen_string_literal: true

class SwaggerRouteHandler < YARD::Handlers::Ruby::Base
  handles method_call(:route)
  namespace_only
  process do
    name = statement.parameters.first.jump(:tstring_content, :ident).source
    object = YARD::CodeObjects::ClassObject.new(namespace, name)
    register(object)
    parse_block(statement.last.last, namespace: object, scope: :class)
  end
end

class SwaggerOnHandler < YARD::Handlers::Ruby::Base
  handles method_call(:on)
  namespace_only
  process do
    parse_block(statement.last.last, namespace: namespace, scope: :class)
  end
end
