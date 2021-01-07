# frozen_string_literal: true

module PUNK
  def self.version
    File.read(File.join(__dir__, '..', '..', '..', 'VERSION'))
  end
end
