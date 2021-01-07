# frozen_string_literal: true

require_relative '../startup/logger'
require_relative '../startup/environment'
require_relative '../startup/task'
require_relative '../startup/database'
require_relative '../startup/cache'

PUNK.store[:state] = :booted
