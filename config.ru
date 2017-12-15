#\-p 3000 --host 0.0.0.0 -q
# frozen_string_literal: true

require_relative 'config/application'

use Rack::Protection, origin_whitelist: ['http://localhost:3000', 'http://127.0.0.1'],
                      except: %i[remote_token session_hijacking]

run API
