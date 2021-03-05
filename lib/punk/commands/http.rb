# frozen_string_literal: true

PUNK::Command.create "GET" do
  description "Perform a HTTP GET request"

  def process
    path, query = args[0].split("?")
    PUNK.app.call(
      "REQUEST_METHOD" => "GET",
      "PATH_INFO" => path,
      "QUERY_STRING" => query,
      "SCRIPT_NAME" => "",
      "rack.input" => StringIO.new
    )
  end
end

PUNK::Command.create "PATCH" do
  description "Perform a HTTP PATCH request"

  def process
    PUNK.app.call(
      "REQUEST_METHOD" => "PATCH",
      "PATH_INFO" => args[0],
      "CONTENT_TYPE" => "text/json",
      "SCRIPT_NAME" => "",
      "rack.input" => StringIO.new(args[1..-1].join)
    )
  end
end

PUNK::Command.create "POST" do
  description "Perform a HTTP POST request"

  def process
    PUNK.app.call(
      "REQUEST_METHOD" => "POST",
      "PATH_INFO" => args[0],
      "CONTENT_TYPE" => "text/json",
      "SCRIPT_NAME" => "",
      "rack.input" => StringIO.new(args[1..-1].join)
    )
  end
end

PUNK::Command.create "PUT" do
  description "Perform a HTTP PUT request"

  def process
    PUNK.app.call(
      "REQUEST_METHOD" => "PUT",
      "PATH_INFO" => args[0],
      "CONTENT_TYPE" => "text/json",
      "SCRIPT_NAME" => "",
      "rack.input" => StringIO.new(args[1..-1].join)
    )
  end
end

PUNK::Command.create "DELETE" do
  description "Perform a HTTP DELETE request"

  def process
    PUNK.app.call(
      "REQUEST_METHOD" => "DELETE",
      "PATH_INFO" => args[0],
      "SCRIPT_NAME" => "",
      "rack.input" => StringIO.new
    )
  end
end
