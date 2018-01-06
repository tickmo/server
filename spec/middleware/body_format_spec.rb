# frozen_string_literal: true

require_relative '../../middleware/body_format'

describe Middleware::BodyFormat do
  let(:app) { proc { |env| [200, env, ['OK']] } }
  subject { described_class.new(app) }
  let(:request) { Rack::MockRequest.new(subject) }
  let(:response) { request.post('/some/path', input: body, 'CONTENT_TYPE' => content_type) }

  describe 'when media type is not JSON' do
    let(:content_type) { 'text/plain' }
    let(:body) { StringIO.new('not_json_body') }

    it "doesn\'t change body" do
      expect(response.header['rack.input']).to eql(body)
    end
  end

  describe 'when media type is JSON' do
    let(:content_type) { 'application/json' }

    describe 'and body in JSON format' do
      let(:hash) { { foo: %w[bar baz bla] } }
      let(:body) { StringIO.new(hash.to_json) }

      it 'body is not changed' do
        expect(response['rack.input'].gets).to eql(hash.to_json)
      end
    end

    describe 'and body not in JSON format' do
      let(:hash)  { { media: { url: 'http://asdasd.com' }, audio: { format: 'aac' } } }
      let(:query) { 'media%5Burl%5D=http%3A%2F%2Fasdasd.com&audio%5Bformat%5D=aac' }
      let(:body)  { StringIO.new(query) }

      it 'restructures body to JSON' do
        expect(response['rack.input'].gets).to eql(hash.to_json)
      end
    end
  end
end
