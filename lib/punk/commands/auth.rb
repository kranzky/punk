# frozen_string_literal: true

PUNK::Command.create "login" do
  description "Authenticate a user by email address or mobile number"

  option shortcut: :c, name: :claim, type: String, description: "The user's email or phone"

  def process
    claim = opts[:claim]
    SemanticLogger.flush
    claim ||= ask("Email or Phone: ")
    response =
      PUNK.app.call(
        "REQUEST_METHOD" => "POST",
        "PATH_INFO" => "/sessions",
        "CONTENT_TYPE" => "text/json",
        "SCRIPT_NAME" => "",
        "rack.input" => StringIO.new({claim: claim}.to_json)
      )
    response = ActiveSupport::JSON.decode(response[-1].first).deep_symbolize_keys
    return if response[:errors].present?
    slug = response[:slug]
    authenticated = false
    while authenticated == false
      SemanticLogger.flush
      secret = ask("Secret: ") { |q| q.echo = "*" }
      response =
        PUNK.app.call(
          "REQUEST_METHOD" => "PATCH",
          "PATH_INFO" => "/sessions/#{slug}",
          "CONTENT_TYPE" => "text/json",
          "SCRIPT_NAME" => "",
          "rack.input" => StringIO.new({secret: secret}.to_json)
        )
      response = ActiveSupport::JSON.decode(response[-1].first).deep_symbolize_keys
      break if response[:errors].present? && response[:errors].first != "Secret is incorrect"
      authenticated = response[:message].present?
    end
    response[:message]
  end
end

PUNK::Command.create "logout" do
  description "Delete the current user session"

  def process
    response =
      PUNK.app.call(
        "REQUEST_METHOD" => "DELETE",
        "PATH_INFO" => "/sessions",
        "SCRIPT_NAME" => "",
        "rack.input" => StringIO.new
      )
    response = ActiveSupport::JSON.decode(response[-1].first).deep_symbolize_keys
    response[:message]
  end
end
