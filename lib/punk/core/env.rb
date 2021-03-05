# frozen_string_literal: true

require "active_support/string_inquirer"

require "date"
require "fileutils"
require "dotenv"

module PUNK
  class Env < Settings
    def logger
      SemanticLogger["PUNK::Env"]
    end

    def initialize(*args)
      super(*args)
      return unless args.empty?
      @loaded = false
      parent_methods = Module.new do
        def to_s
          raise InternalServerError, "Environment not yet loaded" unless @loaded
          env.to_s
        end

        def to_sym
          raise InternalServerError, "Environment not yet loaded" unless @loaded
          env.to_sym
        end

        def env
          ActiveSupport::StringInquirer.new(self[:env].to_s)
        end

        def task
          ActiveSupport::StringInquirer.new(self[:task].to_s)
        end

        def load!
          return if @loaded
          _load
          @loaded = true
        end
      end
      extend(parent_methods)
    end

    private

    def _load
      _load_environment(File.join(PUNK.store.args.path, "..", "env"), ENV.fetch("PUNK_ENV"), PUNK.store.args.task)
      @schema = {}
      _load_schemas(File.join(__dir__, "..", "config"), ENV.fetch("PUNK_ENV"), PUNK.store.args.task)
      _load_schemas(File.join(PUNK.store.args.path, "config"), ENV.fetch("PUNK_ENV"), PUNK.store.args.task)
      @values = @schema.keys.zip(Array.new(@schema.length, nil)).to_h
      _add_config(
        task: PUNK.store.args.task,
        app: {
          path: PUNK.store.args.path
        }
      )
      _load_configs(File.join(__dir__, "..", "config"), ENV.fetch("PUNK_ENV"), PUNK.store.args.task)
      _load_configs(File.join(PUNK.store.args.path, "config"), ENV.fetch("PUNK_ENV"), PUNK.store.args.task)
      _add_environment
      _add_arguments
      _validate
      load(_unflatten(@values))
      @loaded = true
    end

    def _flatten(data)
      results = []
      data.each do |key, value|
        if value.is_a?(Hash)
          _flatten(value).each do |k, v|
            results << [[key.to_sym, k].flatten, v]
          end
        else
          results << [[key.to_sym], value]
        end
      end
      results.to_h
    end

    def _unflatten(data)
      results = {}
      data.each do |key, value|
        name = key.join(".")
        search = results
        while key.length > 1
          item = key.shift
          search[item] ||= {}
          unless search[item].is_a?(Hash)
            logger.warn "Skipping #{name} due to conflicted nesting"
            next
          end
          search = search[item]
        end
        search[key[0]] = value
      end
      results
    end

    def _load_schema(path)
      return unless File.exist?(path)
      logger.trace "Loading schema #{path}..."
      _flatten(ActiveSupport::JSON.decode(File.read(path))).each do |key, value|
        override = true
        required = false
        key.map! do |name|
          match = /^(_?)([a-z_]+)(!?)$/.match(name)
          raise InternalServerError, "Invalid schema key: #{key.join(".")}" if match.nil?
          override &&= match[1] != "_"
          required ||= match[3] == "!"
          match[2].to_sym
        end
        raise InternalServerError, "Duplicate schema key: #{key.join(".")}" if @schema.key?(key)
        @schema[key] = {
          required: required,
          override: override,
          validate: value
        }
      end
    end

    def _load_schemas(base, name = nil, dir = nil)
      base = File.expand_path(base)
      _load_schema(File.join(base, "schema.json"))
      _load_schema(File.join(base, "schema_#{name}.json")) unless name.nil?
      _load_schemas(File.join(base, dir), name) unless dir.nil?
    end

    def _validate
      @schema.each do |key, value|
        next unless value[:required]
        current_value = @values[key]
        raise InternalServerError, "Missing required configuration value: #{key.join(".")}" if current_value.nil?
      end
    end

    def _typecast(key, value, validation, required)
      valid = false
      match = /^\$([A-Z][A-Z_]+[A-Z])$/.match(value) if value.is_a?(String)
      if match
        value = ENV.fetch(match[1], nil)
        raise InternalServerError, "Env var does not exist: #{match[1]}" if value.nil? && required
      end
      value =
        case validation
        when /^Enum\((.*)\)$/
          values = Regexp.last_match(1).split(/ *, */)
          valid = values.include?(value)
          value.to_sym
        when /^Symbol\(\/(.*)\/\)$/
          regexp = Regexp.last_match(1)
          valid = value =~ /#{regexp}/
          value.to_sym
        when /^Symbol$/
          valid = true
          value.to_sym
        when /^String\(\/(.*)\/\)$/
          regexp = Regexp.last_match(1)
          valid = value =~ /#{regexp}/
          value.to_s
        when /^String$/
          valid = true
          value.to_s
        when /^Dir\(\/(.*)\/\)$/
          regexp = Regexp.last_match(1)
          valid = value =~ /#{regexp}/
          FileUtils.mkdir_p(value)
          valid &&= Dir.exist?(value)
          value
        when /^Dir$/
          FileUtils.mkdir_p(value)
          valid = Dir.exist?(value)
          value
        when /^File\(\/(.*)\/\)$/
          regexp = Regexp.last_match(1)
          valid = value =~ /#{regexp}/
          dir = File.dirname(value)
          FileUtils.mkdir_p(dir)
          FileUtils.touch(value)
          valid &&= File.file?(value)
          value
        when /^File$/
          dir = File.dirname(value)
          FileUtils.mkdir_p(dir)
          FileUtils.touch(value)
          valid = File.file?(value)
          value
        when /^Flag$/
          valid = value.is_a?(TrueClass) || value.is_a?(FalseClass)
          value
        when /^Integer$/
          valid = value.is_a?(Integer)
          value
        when /^Float$/
          valid = value.is_a?(Float) || value.is_a?(Integer)
          value.to_f
        when /^Date$/
          valid = Date.parse(value)
          value
        when /^Email$/
          valid = value =~ /^[^@]+@[^@]+$/
          value
        when /^URI$/
          valid = value =~ /^[a-z]+:\/\/[^ ]+$/
          value
        when /^Array$/
          valid = value.is_a?(Array)
          value
        else
          raise InternalServerError, "Unknown validation: #{validation}"
        end
      raise InternalServerError, "#{value} is invalid for #{key.join(".")}: #{validation}" unless valid
      value
    end

    def _add_value(key, value)
      schema = @schema[key]
      raise InternalServerError, "Configuration not found in schema: #{key.join(".")}" if schema.nil?
      unless schema[:override]
        current_value = @values[key]
        raise InternalServerError, "Cannot override configuration value: #{key.join(".")}" unless current_value.nil?
      end
      @values[key] = _typecast(key, value, schema[:validate], schema[:required])
    end

    def _add_config(data)
      _flatten(data).each do |key, value|
        _add_value(key, value)
      end
    end

    def _load_config(path)
      return unless File.exist?(path)
      logger.trace "Loading config #{path}..."
      _add_config(ActiveSupport::JSON.decode(File.read(path)))
    end

    def _load_configs(base, name = nil, dir = nil)
      base = File.expand_path(base)
      _load_config(File.join(base, "defaults.json"))
      _load_config(File.join(base, "#{name}.json")) unless name.nil?
      _load_configs(File.join(base, dir), name) unless dir.nil?
    end

    def _load_dotenv(path)
      return unless File.exist?(path)
      logger.trace "Loading dotenv #{path}..."
      Dotenv.load(path)
    end

    def _load_environment(base, name = nil, dir = nil)
      base = File.expand_path(base)
      _load_environment(File.join(base, dir), name) unless dir.nil?
      _load_dotenv(File.join(base, "locals.sh"))
      _load_dotenv(File.join(base, "#{name}.sh"))
      _load_dotenv(File.join(base, "defaults.sh"))
    end

    def _add_environment
      ENV.each do |key, value|
        key = key.downcase
        match = /^punk_(.*)$/.match(key)
        next unless match
        key = match[1].split("_").reject(&:empty?).map(&:to_sym)
        _add_value(key, value)
      end
    end

    def _add_arguments
      _add_config(PUNK.store.args.config)
    end
  end

  def self.env
    PUNK.get.env
  end

  def self.task
    PUNK.get.task
  end
end

PUNK::Interface.register(:get) do
  PUNK::Env.new
end

PUNK.inject :get
