# frozen_string_literal: true

require './spec/spec_helper'
require './spec/shared/shared_examples'

describe 'API' do
  describe 'configuration' do
    let(:not_existed_path)     { '/any_not_existed_path' }
    let(:routing_error_status) { 404 }
    let(:routing_error_body) do
      {
        errors: [
          { status: routing_error_status, title: 'Ruting Error',
            details: "Route '#{not_existed_path}' wasn't found" }
        ]
      }.to_json
    end

    before { get not_existed_path }

    it_behaves_like 'response with correct Content-Type'
    it_behaves_like 'response with JSON'
    it_behaves_like 'response with correct status', 404
    it 'returns correct body of routing error' do
      expect(response.body).to eql routing_error_body
    end
  end
end
