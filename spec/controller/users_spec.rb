require 'spec_helper'

describe UsersController, type: :controller do
  let(:user) { FactoryGirl.create(:user) }

  describe 'index' do
    before { visit users_path }

    it 'exist' do
      expect(response.code).to eql('200')
    end
  end

  describe 'new' do
    before { visit new_user_path }

    it 'exist' do
      expect(response.code).to eql('200')
    end
  end

  describe 'show' do
    before { visit user_path(user.id) }

    it 'exist' do
      expect(response.code).to eql('200')
    end
  end

  describe 'edit' do
    before { visit edit_user_path(user.id) }

    it 'exist' do
      expect(response.code).to eql('200')
    end
  end
end
