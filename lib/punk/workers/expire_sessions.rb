# frozen_string_literal: true

module PUNK
  class ExpireSessionsWorker < Worker
    def process
      Session.expiring.each(&:timeout?)
    end
  end
end
