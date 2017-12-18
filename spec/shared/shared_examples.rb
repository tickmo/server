# frozen_string_literal: true

shared_examples 'response with correct Content-Type' do
  let(:header_name)  { 'Content-Type' }
  let(:header_value) { 'application/json' }

  it { expect(response.header[header_name]).to eql header_value }
end

shared_examples 'response with JSON' do
  it { expect(valid_json?(response.body)).to eql true }
end

shared_examples 'response with correct status' do |status|
  let!(:status) { status ||= 200 }
  it { expect(response.status).to eql status }
end

shared_examples 'endpoint' do |status|
  it_behaves_like 'response with JSON'
  it_behaves_like 'response with correct Content-Type'
  it_behaves_like 'response with correct status', status
end
