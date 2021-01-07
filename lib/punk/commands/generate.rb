# frozen_string_literal: true

PUNK::Command.create "generate" do
  shortcut 'g'
  description "Generate routes, actions, models, views, services or workers"

  def process
    case args.join(' ')
    when 'route', 'action', 'model', 'view', 'service', 'worker', 'scaffold'
      "TBD"
    when '', 'help'
      "? specify one of: routes, actions, models, views, services, scaffold"
    else
      "? unkown arguments: #{args.join(',')}"
    end
  end
end

__END__
{route}
# frozen_string_literal: true

PUNK.route('{pluralized_name}') do
  authorize!

  # route: GET|PATCH|DELETE /{pluralized_name}/:id
  on :id do |{name}_id|
    @{name} = {classified_name}[{name}_id.to_i]
    get { present {classified_name}View, {name}: @{name} }
    patch { perform Update{classified_name}, args.merge({name}: @{name}) }
    delete { perform Destroy{classified_name}, {name}: @{name} }
  end

  # route: GET|POST /{pluralized_name}
  get { perform List{pluralized_classified_name}
  post { perform Create{classified_name}, args }
end
{action}
{list_action}
{create_action}
{update_action}
{destroy_action}
{model}
{view}
{list_view}
{json_template}
{json_list_template}
{csv_template}
{csv_list_template}
{html_template}
{html_list_template}
{xml_template}
{xml_list_template}
{service}
