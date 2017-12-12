# frozen_string_literal: true

module V1
  module Serializers
    class Base
      include JSONAPI::Serializer

      def self_link
        "/v1#{super}"
      end
    end
  end
end
