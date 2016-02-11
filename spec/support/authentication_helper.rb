module AuthenticationHelper
  def auth_header(user)
    {'Authorization' => "Token token=\"#{user.api_authentication_token}\", email=\"#{user.email}\""}
  end

  def request_with_header(path, header, options = { type: 'get' })
    case options[:type]
    when 'get'
      get path, '', header
    when 'post'
      post path, '', header
    when 'patch'
      patch path, '', header
    when 'delete'
      delete path, '', header
    end
    return response
  end

  def auth_request(path, options = { type: 'get' })
    user = FactoryGirl.create(:user)
    header = auth_header(user)
    request_with_header(path, header, options)
  end

  alias_method :sign_and_request, :auth_request
end

  def it_return_correct_status(status)
    it "returns the correct status" do
      expect(response.status).to eql(status)
    end
  end

RSpec.configure do |config|
  config.include AuthenticationHelper, :type => :request
end
