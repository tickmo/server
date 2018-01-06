# frozen_string_literal: true

class API < Grape::API
  insert_after Grape::Middleware::Formatter, Grape::Middleware::Logger, logger: Tickmo::Application.logger
  format          :json
  content_type    :json, 'application/json'
  error_formatter :json, V1::APIHelpers::ErrorFormatter

  helpers V1::APIHelpers::ExceptionHandler

  rescue_from :all { |exception| handle_exception(exception) }

  mount V1::Base

  # If requested route was not found, return the client error.
  route :any, '*path' do
    error_status = 404
    message = "Route '#{request.path}' wasn't found"
    error!({ errors: [{ status: error_status, title: 'Ruting Error', details: message }] }, error_status)
  end

  add_swagger_documentation(
    info: { title: 'Tickmo API' },
    mount_path: '/apidocs'
  )
end
