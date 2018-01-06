# frozen_string_literal: true

module V1
  module APIHelpers
    module ExceptionHandler
      def handle_exception(exception)
        status = 500
        message = JSONAPI::Serializer.serialize_errors(Rack::Utils::HTTP_STATUS_CODES[status])

        exception.backtrace.each { |line| Tickmo::Application.logger.error(line) } if exception.backtrace.any?
        error!(message, status)
      end
    end
  end
end
