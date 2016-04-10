describe Api::V1::SessionsController, type: :request do
  context :create do
    describe 'success' do
      let(:user) { FactoryGirl.create(:user) }
      let(:data) { ActionController::Parameters.new('user' => { 'email' => user.email, 'password' => 'password' }) }
      before { post api_v1_sessions_path, data }

      it_return_correct_status(201)

      it 'returns the correct authentication token' do
        token_value = User.find(user.id).api_authentication_token
        regex = /\"token\"\:\"#{token_value}/
        expect(regex.match(response.body).length).to eql(1)
      end
    end

    describe 'fail' do
      let(:wrong_data) do
        ActionController::Parameters.new('user' => { 'email' => 'not.existed@post.dom', 'password' => 'foo bar' })
      end
      before { post api_v1_sessions_path, wrong_data }

      it_return_correct_status(401)
    end
  end
end
