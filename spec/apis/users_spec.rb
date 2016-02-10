require 'spec_helper'

describe Api::V1::UsersController, type: :request do
  let(:auth_user) { FactoryGirl.create(:user) }

  context :index do

    describe "not authorized" do
      before { get api_v1_users_path }

      it "returns the correct status" do
        expect(response.status).to eql(401)
      end
    end

    describe "authorized" do
      before do
        5.times{ FactoryGirl.create(:user) }
        sign_and_request(api_v1_users_path)
      end

      it "returns the correct status" do
        expect(response.status).to eql(200)
      end

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

    it "returns the correct status" do
      expect(response.status).to eql(201)
    end
  end

  context :show do

    describe "not authorized" do
      let(:uid) { 1 }
      before { get api_v1_user_path(uid) }

      it "returns the correct status" do
        expect(response.status).to eql(401)
      end
    end

    describe "authorized" do
      before do
        auth_request(api_v1_user_path(auth_user.id))
      end

      it "returns the correct status" do
        expect(response.status).to eql(200)
      end

      it "returns the data in the body" do
        body = HashWithIndifferentAccess.new(MultiJson.load(response.body))
        expect(body[:user][:name]).to eql(auth_user.name)
        expect(body[:user][:updated_at]).to eql(auth_user.updated_at.iso8601)
      end
    end
  end

  context :update do
  end

  context :delete do

    describe "not authorized" do
      let(:uid) { 1 }
      before { delete api_v1_user_path(uid) }

      it "returns the correct status" do
        expect(response.status).to eql(401)
      end
    end

    context "when the resource does NOT exist" do
      before do
        auth_request(api_v1_user_path(auth_user.id + 100), type: 'delete')
      end

      it "returns the correct status" do
        expect(response.status).to eql(404)
      end
    end

    context "when the resource does exist" do
      before do
        auth_request(api_v1_user_path(auth_user.id), type: 'delete')
      end

      it "returns the correct status" do
        expect(response.status).to eql(204)
      end

      it "actually deletes the resource" do
        expect(User.find_by(id: auth_user.id)).to eql(nil)
      end
    end
  end
end
