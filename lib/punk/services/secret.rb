# frozen_string_literal: true

module PUNK
  class SecretService < Service
    def process
      (SecureRandom.random_number(900_000) + 100_000).to_s
    end
  end
end
