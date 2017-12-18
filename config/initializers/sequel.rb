# frozen_string_literal: true

require 'sequel'
require_relative '../db_config'

DB = Sequel.connect(DB_CONFIG)
DB.logger = Tickmo::Application.logger
