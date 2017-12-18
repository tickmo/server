# frozen_string_literal: true

module V1
  class FakeEndpoint < V1::Base
    namespace :fake_endpoint do
      get do
        { message: 'Hi!' }
      end

      params do
        requires 'message',     type: String
        optional 'description', type: String
      end

      post :create do
        { message: params['message'], description: params['description'] }
      end
    end
  end
end
