# frozen_string_literal: true

module Middleware
  class BodyFormat
    CONTENT_TYPE = 'application/json'

    def initialize(app)
      @app = app
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      restructure_body(env)
      @app.call(env)
    end

    private

    def restructure_body(env)
      return unless env['CONTENT_TYPE'] == CONTENT_TYPE

      raw_body = env['rack.input'].dup.gets
      json = valid_json?(raw_body) ? raw_body : Rack::Utils.parse_nested_query(raw_body, '&').to_json
      env['rack.input'] = StringIO.new(json)
    end

    def valid_json?(json)
      JSON.parse(json)
      true
    rescue JSON::ParserError
      false
    end
  end
end
