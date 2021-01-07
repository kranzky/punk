# frozen_string_literal: true

require_relative '../../punk'

require 'highline/import'

PUNK.init(task: 'console', config: { app: { name: 'Punk!' } }).exec

PUNK.commands(:pry)

say HighLine.color('Commands: "reload!", "perform [action]", "present [view]", "run [service]".  Type "help rr2go" for more.', :green, :bold)

PUNK.db.loggers.first.level = :debug
