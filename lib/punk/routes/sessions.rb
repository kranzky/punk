# frozen_string_literal: true

# @resource Sessions
#
# Handle the authentication flow.
PUNK.route("sessions") do
  # Challenge the claim of someone having a particular email address or phone number.
  # @path [POST] /sessions
  # @parameter claim(required) [string] An email address or mobile phone number.
  # @response [Session] 201 Pending session created
  # @response [Error] 400 Invalid claim, or the user is already authenticated
  # @method post
  # @example 201
  #   {
  #     "slug": "deadbeef-1234-5678-abcd-000000000000",
  #     "message": "A code has been sent to your email address."
  #   }
  # @example 400
  #   {
  #     "message": "Validation failed",
  #     "errors": ["Claim is not an email or phone."]
  #   }
  #
  # route: POST /sessions
  post do
    require_anonymous!
    perform PUNK::CreateSessionAction, args.merge(remote_addr: request.ip || PUNK::Session.default_values[:remote_addr].to_s, user_agent: request.env["HTTP_USER_AGENT"] || PUNK::Session.default_values[:user_agent])
  end

  # route: GET /sessions/current
  on "current" do
    require_session!
    get do
      perform PUNK::ShowUserAction, user: current_user
    end
  end

  # route: PATCH /sessions/:slug
  on :id do |slug|
    require_anonymous!
    user_session = PUNK::Session.find(slug: slug)
    # Verify a pending session by providing proof of access to the email address or phone number.
    # @path [PATCH] /sessions/{slug}
    # @parameter secret(required) [string] The verification code sent by email or sms.
    # @response [Info] 200 Session verified and cookie created
    # @response [Error] 400 Invalid secret
    # @method patch
    # @example 200
    #   {
    #     "message": "You are now logged in."
    #   }
    # @example 400
    #   {
    #     "message": "Validation failed",
    #     "errors": ["Secret does not match."]
    #   }
    patch do
      view = perform PUNK::VerifySessionAction, args.merge(session: user_session)
      request.session[:session_id] = user_session.id if user_session&.active?
      view
    end
  end

  # Allow the current user to access their active sessions.
  # @path [GET] /sessions
  # @response [Array<Session>] 200 List of sessions
  # @response [Error] 401 The user was not authenticated
  # @method get
  # @example 200
  #   [{
  #     "id": "deadbeef-1234-5678-abcd-000000000000",
  #     "client": {...}
  #   }]
  # @example 401
  #   {
  #     "message": "you are not authenticated.",
  #     "errors": ["cannot find session"]
  #   }
  #
  # route: GET /tenants
  get do
    require_session!
    perform PUNK::ListSessionsAction, user: current_user
  end

  # Allow the current user to logout.
  # @path [DELETE] /sessions
  # @response [Info] 200 Session destroyed and cookie cleared
  # @response [Error] 401 The user was not authenticated
  # @method destroy
  # @example 200
  #   {
  #     "message": "You have logged out."
  #   }
  # @example 401
  #   {
  #     "message": "You are not authenticated.",
  #     "errors": ["No session exists"]
  #   }
  #
  # route: DELETE /sessions
  delete do
    require_session!
    view = perform PUNK::ClearSessionAction, session: current_session
    clear_session if current_session&.deleted?
    view
  end
end
