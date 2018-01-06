# frozen_string_literal: true

module V1
  module APIHelpers
    module ErrorFormatter
      class << self
        def call(message, backtrace, _, _options = {})
          Tickmo::Application.logger.error(backtrace.each { |line| logger.error line }) if backtrace.any?

          ::Grape::Json.dump(wrap_message(message))
        end

        private

        def wrap_message(message)
          return message if message.is_a?(Grape::Exceptions::ValidationErrors) || message.is_a?(Hash)

          JSONAPI::Serializer.serialize_errors(message)
        end
      end
    end
  end
end
