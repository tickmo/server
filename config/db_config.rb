# frozen_string_literal: true

require 'yaml'

DB_CONFIG = YAML.safe_load(File.open('config/database.yml'))[ENV['RACK_ENV'] || 'development']
DB_ADMIN_CONFIG = DB_CONFIG.merge('database' => 'postgres', 'schema_search_path' => 'public')
