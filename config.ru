#\-p 3000 --host 0.0.0.0 -q
# frozen_string_literal: true

require_relative 'config/application'
require_relative 'middleware/body_format'

origins = %w[http://localhost:3001 http://localhost:3002].freeze

use Rack::Protection, origin_whitelist: origins,
                      except: %i[remote_token session_hijacking]
use Rack::Cors do
  allow do
    origins origins
    resource '*', headers: %w[Content-Type], methods: %i[get post delete patch options]
  end
end
use Middleware::BodyFormat

run API
