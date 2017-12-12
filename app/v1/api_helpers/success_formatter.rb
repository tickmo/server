# frozen_string_literal: true

module V1
  module APIHelpers
    module SuccessFormatter
      OPTIONS = { skip_collection_check: true, namespace: 'V1::Serializers' }.freeze

      class << self
        def call(object, _)
          options = OPTIONS.merge(is_collection: object.is_a?(Array))
          return JSONAPI::Serializer.serialize(object, options).to_json if model?(object)
          return object.to_json if object.respond_to?(:to_json)

          MultiJson.dump(object)
        end

        private

        def model?(object)
          object.is_a?(Sequel::Model) || object.is_a?(Array) && object.all? { |o| o.is_a?(Sequel::Model) }
        end
      end
    end
  end
end
