#\-p 3000 --host 0.0.0.0 -q
# frozen_string_literal: true

require_relative 'config/application'

generate_secure_hex = proc { SecureRandom.hex(32) }

cookies_parameters = {
  key: 'rack.session',
  domain: 'foo.com',
  secret: generate_secure_hex.call,
  old_secret: generate_secure_hex.call
}

use Rack::Reloader, 0 # Unfortunately it doesn't work for Grape.
use Rack::Session::Pool, cookies_parameters
use Rack::Protection, origin_whitelist: ['http://127.0.0.1:3000']
use Rack::Protection::AuthenticityToken
use Rack::Protection::RemoteReferrer
use Rack::Protection::StrictTransport
use Rack::Protection::EscapedParams
run API
