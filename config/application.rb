# frozen_string_literal: true

# Require all gems listed at Gemfile.
require File.expand_path('../boot', __FILE__)
require 'active_support/dependencies'

module Tickmo
  class Application
    OUT = "./log/#{ENV['RACK_ENV']}.log"

    class << self
      def logger
        @logger ||= define_logger
      end

      private

      def define_logger
        out = OUT.dup.prepend('| tee ') if ENV['RACK_ENV'] != 'test'
        Logger.new(out || OUT, level: :info) # TODO: Provide different levels depended on environments.
      end
    end
  end
end

# Initialize configurations.
Dir['./config/initializers/*.rb'].each { |file| require file }

# Autoload application sources.
ActiveSupport::Dependencies.autoload_paths = %w[./app ./models]
