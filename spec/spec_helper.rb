# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'test'

# require 'support/test_methods'
require 'rack/test'
require 'factory_bot'
require 'pry'
require File.expand_path('../../config/application.rb', __FILE__)
Dir['./spec/support/**/*.rb'].each { |file| require file }

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration

RSpec.configure do |config|
  # Default configurations.
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include TestMethods
end
