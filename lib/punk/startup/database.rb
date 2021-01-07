# frozen_string_literal: true

require 'sequel'

module Sequel
  def self.json_parser_error_class
    ActiveSupport::JSON.parse_error
  end

  def self.parse_json(json)
    ActiveSupport::JSON.decode(json).deep_symbolize_keys
  end

  class Database
    def log_connection_yield(sql, conn, args=nil, &block)
      return unless @loggers.first
      if conn && log_connection_info
        @loggers.first.tagged(conn.__id__) do
          log_semantic(sql, args, &block)
        end
      else
        log_semantic(sql, args, &block)
      end
    end

    def log_semantic(sql, args)
      return unless @loggers.first
      message = "#{sql}#{"; #{args.inspect}" if args}"
      if log_warn_duration
        @loggers.first.measure_warn(message, min_duration: log_warn_duration) do
          yield
        end
      else
        @loggers.first.measure_debug(message) do
          yield
        end
      end
    end
  end
end

module PUNK
  def self.migration(&block)
    Sequel::MigrationDSL.create(&block)
  end
end

PUNK::Interface.register(:db) do
  PUNK.profile_debug('db_connect', url: PUNK.get.db.url) do
    pg = Sequel.connect(PUNK.get.db.url, logger: SemanticLogger['PUNK::SQL'])
    pg.extension :pg_enum, :pg_range, :pg_array, :pg_json, :pg_row, :pg_timestamptz, :pg_inet
    Sequel.extension :pg_array_ops, :pg_range_ops, :pg_json_ops, :pg_row_ops, :named_timezones, :thread_local_timezones
    pg
  end
end

PUNK.inject :db
