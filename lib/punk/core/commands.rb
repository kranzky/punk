# frozen_string_literal: true

require_relative '../framework/command'

module PUNK
  def self.commands(target, scope=nil)
    path = File.expand_path(File.join(__dir__, '..', 'commands'))
    PUNK.profile_debug("commands", path: path) do
      Dir.glob(File.join(path, '**/*.rb')).sort.each { |file| require(file) }
    end
    path = File.expand_path(File.join(PUNK.get.app.path, 'commands'))
    PUNK.profile_debug("commands", path: path) do
      Dir.glob(File.join(path, '**/*.rb')).sort.each { |file| require(file) }
    end
    case target
    when :commander
      require_relative 'commander'
      Command.commander
    when :pry
      require_relative 'pry'
      Command.pry
    when :spec
      Command.spec(scope)
    end
  end
end
