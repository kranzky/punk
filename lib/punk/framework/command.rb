# frozen_string_literal: true

module SpecHelpers
end

module PUNK
  class Command
    attr_accessor :args, :opts

    def self.create(name, &block)
      command = new
      command.send(:_init, name)
      PUNK.store.commands ||= {}
      PUNK.store.commands[name] = command
      command.instance_eval(&block)
    end

    def shortcut(name)
      instance_variable_set(:@shortcut, name)
    end

    def description(text)
      instance_variable_set(:@description, text)
    end

    def option(name:, description:, shortcut: nil, type: String)
      @options[name] = {
        name: name,
        description: description,
        shortcut: shortcut,
        type: type
      }
    end

    def self.pry
      PUNK.store.commands.each_value do |command|
        command.send(:_pry)
      end
    end

    def self.commander
      PUNK.store.commands.each_value do |command|
        command.send(:_commander)
      end
    end

    def self.spec(scope)
      PUNK.store.commands.each_value do |command|
        command.send(:_spec, scope)
      end
    end

    def process
      raise NotImplemented, "command must provide process method"
    end

    private

    def _init(name)
      @name = name
      @shortcut = nil
      @description = nil
      @options = {}
    end

    def _pry
      command = Pry::Commands.create_command(@name) {} # rubocop:disable Lint/EmptyBlock
      command.description = @description
      command.instance_variable_set(:@group, "rr2go")
      command.class_eval do
        define_method(:options) do |opt|
          rr_command = PUNK.store.commands[match]
          rr_command.instance_variable_get(:@options).each_value do |option|
            opt.on option[:shortcut], option[:name], option[:description], argument: true, as: option[:type]
          end
        end
        define_method(:process) do
          rr_command = PUNK.store.commands[match]
          rr_command.instance_variable_set(:@args, args)
          rr_command.instance_variable_set(:@opts, opts.to_h)
          result = rr_command.process
          SemanticLogger.flush
          output.puts result
        end
      end
    end

    def _commander
      command @name do |c|
        c.description = @description
        @options.each_value do |option|
          c.option "-#{option[:shortcut]}", option[:description], "--#{option[:name]} #{option[:type].to_s.upcase}", option[:type]
        end
        c.action do |args, opts|
          @args = args
          @opts = opts.__hash__
          PUNK.exec
          result = process
          SemanticLogger.flush
          puts result # rubocop:disable Rails/Output
        end
      end
      return unless @shortcut
      alias_command @shortcut, @name
    end

    def _spec(scope)
      this = self
      SpecHelpers.send(:define_method, "command_#{@name}") do |*args, **kwargs|
        this.instance_variable_set(:@args, args)
        this.instance_variable_set(:@opts, kwargs)
        this.process
      end
      scope.include SpecHelpers
    end
  end
end
