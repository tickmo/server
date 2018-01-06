# frozen_string_literal: true

class TestAPI < Grape::API
  # The TestAPI class keeps test resourses, that necessary only for test environment.

  API.get '/error_path' do
    raise StandardError, 'message'
  end

  mount API # Mount regular application.
end
