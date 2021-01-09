# frozen_string_literal: true

require 'roda'
require 'sidekiq/web'
require 'sidekiq/cron/web'
require 'rack/protection'

require_relative '../plugins/all'

# don't use rack session for sidekiq (we do our own auth when routing)
Sidekiq::Web.set(:sessions, false)
# TODO: need custom roda route csrf in sidekiq web forms
Sidekiq::Web.use(::Rack::Protection, use: :none, logging: true, logger: SemanticLogger['PUNK::RPT'])

module PUNK
  def self.route(name, &block)
    PUNK.profile_info("route", path: name) do
      PUNK::App.route(name) do |r|
        r.scope.instance_exec(&block)
      end
    end
  end

  ROUTES = Tempfile.new("routes.json").path
  PUNK.profile_info("generate", path: ROUTES) do
    system "roda-parse_routes -f #{ROUTES} #{File.expand_path(File.join(PUNK.get.app.path, 'routes', '*'))}"
  end

  class App < Roda
    include Loggable

    REMOTE = PUNK.env.staging? || PUNK.env.production?
    PUBLIC = File.join(PUNK.get.app.path, '..', 'www')
    index_path = File.join(PUBLIC, 'index.html')
    INDEX =
      if File.exist?(index_path)
        File.read(index_path)
      else
        <<~INDEX_HTML
          <!DOCTYPE html>
          <html>
            <head>
              <title>Let's Punk!</title>
            </head>
            <body>
              <h1>Let's Punk!</h1>
              <p>Are you <a href="https://github.com/kranzky/lets-punk">ready</a> to rock?</p>
            </body>
          </html>
        INDEX_HTML
      end

    plugin :sessions, secret: [PUNK.get.cookie.secret].pack('H*'),
                      key: PUNK.get.cookie.key,
                      max_seconds: 1.year.to_i,
                      max_idle_sessions: 1.month.to_i,
                      cookie_options: {
                        same_site: REMOTE ? :strict : :lax,
                        secure: REMOTE,
                        max_age: 1.year.to_i
                      }
    plugin :ssl if REMOTE
    plugin :cors, PUNK.get.app.client
    # plugin :route_csrf
    plugin :all_verbs
    plugin :class_level_routing
    plugin :delegate
    plugin :indifferent_params
    plugin :json_parser
    plugin :path_rewriter
    plugin :slash_path_empty
    plugin :multi_route
    plugin :type_routing, types: { csv: 'text/csv' }, default_type: :json
#   plugin :route_list, file: ROUTES TODO
    plugin :disallow_file_uploads
    plugin :public, root: PUBLIC

    plugin :default_headers, 'Content-Type' => 'text/html', 'Content-Security-Policy' => "default-src 'self';img-src *", 'Strict-Transport-Security' => 'max-age=16070400;', 'X-Frame-Options' => 'deny', 'X-Content-Type-Options' => 'nosniff', 'X-XSS-Protection' => '1; mode=block'

    plugin :error_handler
    plugin :not_found
    plugin :hooks

    request_delegate :root, :on, :is, :get, :post, :redirect, :patch, :delete

    rewrite_path(/\A\/?\z/, '/index.html')
    rewrite_path(/\A\/api\/?\z/, '/api/index.html')

    def require_session!
      begin
        # TODO
        @_current_session = nil # Session[request.session['session_id']]
        if @_current_session&.active?
          @_current_session.touch
        else
          clear_session
          @_current_session = nil
        end
      rescue StandardError => e
        exception(e)
        raise Unauthorized, e.message
      end
      raise Unauthorized, 'Session does not exist' if @_current_session.nil?
      PUNK.logger.info "require_session!", { current_session: current_session.inspect, current_identity: current_identity.inspect, current_user: current_user.inspect }.inspect
    end

    def require_anonymous!
      raise BadRequest, "Session already exists" if request.session.present?
      PUNK.logger.info "require_anonymous!"
    end

    def require_tenant!
      raise Unauthorized, 'Session does not exist' if @_current_session.nil?
      @_current_tenant = current_user.tenants_dataset[id: params[:tenant_id]]
      PUNK.logger.info "require_tenant!", { current_tenant: @_current_tenant.inspect }.inspect
    end

    def args
      params.transform_keys(&:to_sym)
    end

    def current_session
      @_current_session
    end

    def current_identity
      @_current_session&.identity
    end

    def current_user
      @_current_session&.user
    end

    def current_tenant
      @_current_tenant
    end

    def perform(action_class, **kwargs)
      raise InternalServerError, "Not an action: #{action_class}" unless action_class < Action
      render action_class.perform(**kwargs)
    end

    def present(view_class, **kwargs)
      raise InternalServerError, "Not a view: #{view_class}" unless view_class < View
      render view_class.present(**kwargs)
    end

    PUNK_CONTENT_TYPE_LOOKUP = {
      csv: 'text/csv',
      html: 'text/html',
      json: 'application/json',
      xml: 'application/xml'
    }.freeze
    def render(view)
      raise InternalServerError, "Not a view: #{view}" unless view.is_a?(View)
      format = request.requested_type
      view.profile_info("render", format: format) do
        response.status = view.status if view.is_a?(Fail)
        response['Content-Type'] = PUNK_CONTENT_TYPE_LOOKUP[format]
        view.render(format)
      end
    end

    error do |e|
      exception(e, current_user: current_user)
      case e
      when BadRequest
        present Fail, message: 'Bad Request', error_messages: [e.message], status: 400
      when Unauthorized
        present Fail, message: "Unauthorized", error_messages: [e.message], status: 401
      when Forbidden
        present Fail, message: "Forbidden", error_messages: [e.message], status: 403
      when NotFound
        present Fail, message: "Not Found", error_messages: [e.message], status: 404
      when NotImplemented
        present Fail, message: "Not Implemented", error_messages: [e.message], status: 501
      when InternalServerError
        present Fail, message: "Internal Server Error", error_messages: [e.message], status: 500
      else
        present Fail, message: "Unknown Failure", error_messages: [e.message], status: 500
      end
    end

    not_found do
      raise NotFound, "Cannot serve #{request.path}" unless request.is_get?
      response.status = 200
      INDEX
    end

    before do
      @_started = Time.now.utc
      name = "#{request.request_method} #{request.path}"
      logger.info "Started #{name} for #{request.ip}", params.deep_symbolize_keys.sanitize.inspect
      logger.trace request.env['HTTP_USER_AGENT']
      # TODO
      # logger.info "Started #{name} for #{request.ip || Session.default_values[:remote_addr].to_s}", params.deep_symbolize_keys.sanitize.inspect
      # logger.trace request.env['HTTP_USER_AGENT'] || Session.default_values[:user_agent]
      logger.trace request.env['HTTP_COOKIE']
      logger.push_tags(name)
      _set_cookie(request.env)
    end

    after do |response|
      status, headers, _body = response
      name = logger.pop_tags(1).join
      duration = 1000.0 * (Time.now.utc - @_started)
      logger.pop_tags
      logger.trace((headers.present? ? headers['Set-Cookie'] : nil) || "(no cookie set)")
      logger.info message: "Completed #{name} status #{status}", duration: duration
      _store_cookie(headers)
    end

    route do |r|
      r.public
      r.on 'jobs' do
        require_session!
        r.run Sidekiq::Web
      end
      r.multi_route
    end

    private

    def _set_cookie(headers)
      return if REMOTE
      return if headers.blank?
      return if headers['HTTP_USER_AGENT'].present?
      return if headers['HTTP_COOKIE'].present?
      cookie_file = 'tmp/.cookie-jar'
      cookie_file += '-test' if PUNK.env.test?
      cookie = File.read(cookie_file) if File.exist?(cookie_file)
      return if cookie.blank?
      headers['HTTP_COOKIE'] = cookie
    end

    def _store_cookie(headers)
      return if REMOTE
      return if headers.blank?
      cookie = headers['Set-Cookie']
      return if cookie.blank?
      cookie_file = 'tmp/.cookie-jar'
      cookie_file += '-test' if PUNK.env.test?
      if cookie =~ /max-age=0/
        File.delete(cookie_file)
      else
        File.open(cookie_file, 'w') { |file| file << cookie }
      end
    end
  end
end
