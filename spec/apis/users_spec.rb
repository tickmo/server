require 'spec_helper'

describe Api::V1::UsersController, type: :request do
  let(:auth_user) { FactoryGirl.create(:user) }

  context :index do

    describe "not authorized" do
      before { get api_v1_users_path }

      it_return_correct_status(401)
    end

    describe "authorized" do
      before do
        5.times{ FactoryGirl.create(:user) }
        sign_and_request(api_v1_users_path)
      end

      it_return_correct_status(200)

      it 'returns the data in the body' do
        body = HashWithIndifferentAccess.new(MultiJson.load(response.body))
        first_user = body[:users][0]
        desire_keys = ["id", "email", "name", "admin", "created_at", "updated_at"]

        expect(body[:users].length).to eql(User.count)
        expect(first_user.keys).to eql(desire_keys)
      end
    end
  end

  context :create do
    let(:data) do
      ActionController::Parameters.new("user" => {
        "email"    => "example-@post.dom",
        "name"     => "Kenna Rebiata",
        "password" => "password",
        "password_confirmation" => "password"
        })
    end

    before do
        post api_v1_users_path, data
      end

    it "new user created" do
      expect(User.find_by(email: data['user']['email'])) != nil
    end

    it_return_correct_status(201)
  end

  context :show do

    describe "not authorized" do
      let(:uid) { 1 }
      before { get api_v1_user_path(uid) }

      it_return_correct_status(401)
    end

    describe "authorized" do
      before do
        auth_request(api_v1_user_path(auth_user.id))
      end

      it_return_correct_status(200)

      it "returns the data in the body" do
        body = HashWithIndifferentAccess.new(MultiJson.load(response.body))
        expect(body[:user][:name]).to eql(auth_user.name)
        expect(body[:user][:updated_at]).to eql(auth_user.updated_at.iso8601)
      end
    end
  end

  context :update do
    let(:new_data) do
      ActionController::Parameters.new("user" => {
        "email"    => "updated@post.dom",
        "name"     => "MD Newest Name",
        "password" => "password",
        "password_confirmation" => "password"
        })
    end

    describe 'not authorized' do
      let(:uid) { 1 }
      before do
        patch api_v1_user_path(uid), new_data
      end

      it_return_correct_status(401)
    end

    describe "authorized" do
      let(:user) { FactoryGirl.create(:user) }
      before { patch api_v1_user_path(user.id), new_data, auth_header(user) }

      it_return_correct_status(200)

      it "successful" do
        expect(User.find(user.id).name).to  eql(new_data[:user][:name])
        expect(User.find(user.id).email).to eql(new_data[:user][:email])
      end

      it "response has header 'Location'" do
        expect(response.headers.key? 'Location')
        expect(response.headers['Location']).to eql(api_v1_user_path(user.id))
      end

      describe "with wrong credentials" do
        let(:wrong_user) { FactoryGirl.create(:user) }
        let(:wrong_data) do
          ActionController::Parameters.new("user" => {
            "email"    => "wrong @ post.dom;",
            "name"     => "MD Newest Name",
            "password" => "password",
            "password_confirmation" => "wrong_password"
            })
        end
        before { patch api_v1_user_path(wrong_user.id), wrong_data, auth_header(wrong_user) }

        it_return_correct_status(422)
      end
    end
  end

  context :delete do

    describe "not authorized" do
      let(:uid) { 1 }
      before { delete api_v1_user_path(uid) }

      it_return_correct_status(401)
    end

    context "when the resource does NOT exist" do
      before do
        auth_request(api_v1_user_path(auth_user.id + 100), type: 'delete')
      end

      it_return_correct_status(404)
    end

    context "when the resource does exist" do
      before do
        auth_request(api_v1_user_path(auth_user.id), type: 'delete')
      end

      it_return_correct_status(204)

      it "actually deletes the resource" do
        expect(User.find_by(id: auth_user.id)).to eql(nil)
      end
    end
  end
end
