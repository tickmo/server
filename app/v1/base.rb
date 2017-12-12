# frozen_string_literal: true

module V1
  class Base < Grape::API
    version 'v1', using: :path
    formatter :json, V1::APIHelpers::SuccessFormatter

    mount V1::FakeEndpoint
  end
end
