# frozen_string_literal: true

# Require all gems listed at Gemfile.
require File.expand_path('../boot', __FILE__)
require 'active_support/dependencies'

# Initialize configurations.
Dir['./config/initializers/*.rb'].each { |file| require file }

# Autoload application sources.
ActiveSupport::Dependencies.autoload_paths = %w[./app ./models]
