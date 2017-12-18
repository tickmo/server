# frozen_string_literal: true

module TestMethods
  include FactoryBot::Syntax::Methods
  include Rack::Test::Methods

  def app
    API.new
  end

  def json_body
    JSON.parse(last_response.body)
  end

  def valid_json?(json)
    JSON.parse(json)
    true
  rescue JSON::ParserError
    false
  end

  alias response last_response
  alias request  last_request
end
