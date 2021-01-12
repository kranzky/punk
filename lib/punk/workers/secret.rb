# frozen_string_literal: true

module PUNK
  class SecretWorker < Worker
    args :name

    def validate
      validates_not_null :name
      validates_not_empty :name
    end

    def process
      secret = SecretService.run.result
      sleep 5 unless PUNK.env.test?
      logger.info "#{name}: #{secret}"
    end
  end
end
