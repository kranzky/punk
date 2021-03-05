# frozen_string_literal: true

require "tilt"

module PUNK
  module Renderable
    FORMATS =
      {
        html: {renderer: :to_html, extension: "slim"},
        json: {renderer: :to_json, extension: "jbuilder"},
        csv: {renderer: :to_csv, extension: "rcsv"},
        xml: {renderer: :to_xml, extension: "xml.slim"}
      }.freeze

    def template(name)
      @template = name
    end

    def render(format)
      raise NotFound, "unknown format '#{format}'" unless FORMATS.key?(format)
      send(FORMATS[format][:renderer])
    end

    def to_html(options = {})
      _render(:html, options)
    end

    def to_json(options = {})
      _render(:json, options)
    end

    def to_csv(options = {})
      _render(:csv, options)
    end

    def to_xml(options = {})
      _render(:xml, options)
    end

    def to_s
      to_json
    end

    def inspect
      to_s
    end

    def to_h
      ActiveSupport::JSON.decode(to_json).to_h.deep_symbolize_keys
    end

    protected

    def _dir
      File.join(PUNK.get.app.path, "templates")
    end

    private

    def _path(format)
      raise InternalServerError, "No template given" unless @template
      base = File.join(_dir, @template)
      ext = FORMATS[format][:extension]
      "#{base}.#{ext}"
    end

    def _render(format, options)
      path = _path(format)
      raise NotImplemented, "No path for template: #{@template}" unless path
      Tilt.new(path).render(self, options)
    rescue LoadError, Errno::ENOENT
      raise NotFound, "Cannot load template: #{path}"
    end
  end
end
