# frozen_string_literal: true

require 'yaml'

module DBConfig
  def config
    YAML.safe_load(File.open('config/database.yml'))[ENV['RACK_ENV'] || 'development']
  end

  def admin_config
    DB_CONFIG.merge('database' => 'postgres', 'schema_search_path' => 'public')
  end
end

include DBConfig

DB_CONFIG = config
DB_ADMIN_CONFIG = admin_config
