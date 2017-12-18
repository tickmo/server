# frozen_string_literal: true

require './spec/spec_helper'
require './spec/shared/shared_examples'

describe 'V1::FakeEndpoint' do
  let(:namespace) { '/v1/fake_endpoint' }

  context :index do
    let(:expected_body) { { 'message' => 'Hi!' } }

    before { get namespace }

    it_behaves_like 'endpoint'
    it { expect(json_body).to eql(expected_body) }
  end
end
