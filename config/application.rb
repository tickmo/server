# frozen_string_literal: true

# Require all gems listed at Gemfile.
require File.expand_path('../boot', __FILE__)
require 'active_support/dependencies'

module Tickmo
  class Application
    def self.logger
      out = "./log/#{ENV['RACK_ENV']}.log"
      out = out.dup.prepend('| tee ') if ENV['RACK_ENV'] != 'test'
      Logger.new(out, level: :info) # TODO: Provide different levels depended on environments.
    end
  end
end

# Initialize configurations.
Dir['./config/initializers/*.rb'].each { |file| require file }

# Autoload application sources.
ActiveSupport::Dependencies.autoload_paths = %w[./app ./models]
