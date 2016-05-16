require 'spec_helper'

describe 'Authentication' do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }

  describe 'signin page' do
    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign In' }

      describe 'after visiting another page' do
        before { click_link 'Home' }
        it { should_not have_selector('div.alert.alert-error') }
      end

      it { should have_title('Sign In') }
      it { should have_selector('div.alert.alert-error') }
    end

    describe 'with valid information' do
      before { sign_in user }

      it { should have_title(user.name) }
      it { should have_link('Users',       href: users_path) }
      it { should have_link('Profile',     href: user_path(user)) }
      it { should have_link('Sign Out',    href: signout_path) }
      it { should_not have_link('Sign In', href: signin_path) }
      it { expect(User.find(user.id).remember_token).not_to be_blank }

      describe 'followed by signout' do
        before { click_link 'Sign Out' }
        it { should have_link 'Sign In' }
      end
    end
  end

  describe 'edit' do
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe 'page' do
      it { should have_content 'Edit your profile' }
      it { should have_title 'Edit Profile' }

      describe 'with valid information' do
        let(:new_name) { 'New Name' }
        let(:new_email) { 'new@post.dom' }
        before do
          fill_in 'Name',             with: new_name
          fill_in 'Email',            with: new_email
          fill_in 'Password',         with: user.password
          fill_in 'Confirm Password', with: user.password
          click_button 'Update Profile'
        end

        it { should have_title(new_name) }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign Out', href: signout_path) }
        specify { expect(user.reload.name).to  eq new_name }
        specify { expect(user.reload.email).to eq new_email }
      end

      describe 'with invalid information' do
        before { click_button 'Update Profile' }

        it { should have_content 'error' }
      end
    end
  end

  describe 'delete' do
    let(:admin) { FactoryGirl.create(:admin) }
    let!(:delete_user) { FactoryGirl.create(:user) }
    before do
      sign_in admin
      visit users_path
    end

    it { should have_link('Destroy', href: user_path(delete_user)) }
    it 'changes users count' do
      expect { click_link('Destroy', match: :first) }.to change(User, :count).by(-1)
    end
  end

  describe 'signup' do
    before { visit signup_path }
    let(:submit) { 'Create Profile!' }

    it { should have_title(full_title('Sign Up')) }
    it { should have_selector('h1', text: 'Create Profile') }

    describe 'with invalid information' do
      it 'should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe 'after submission' do
        before { click_button submit }

        it { should have_content('error') }
        it { should have_title('Sign Up') }
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'Name',             with: 'Example User'
        fill_in 'Email',            with: 'user@example.com'
        fill_in 'Password',         with: 'foobar'
        fill_in 'Password Confirmation', with: 'foobar'
      end

      it 'should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }
        let(:flash_message) { 'User was successfully created.' }

        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-notice', text: flash_message) }
      end
    end
  end

  describe 'authorization' do
    describe 'for non-signed-in users' do
      it { should_not have_link(full_title('Users')) }
      it { should_not have_link(full_title('Sign Out')) }

      describe 'in the Users controller' do
        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }

          it { should have_title('Sign In') }
        end

        describe 'submitting to the update action', type: :request do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe 'users page is hide for not registered users' do
          before { visit users_path }

          it { should have_title(full_title('Sign In')) }
        end
      end
    end

    describe 'as wrong user', type: :request do
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@post.dom') }
      before { sign_in user, no_capybara: true }

      describe 'submitting a GET request to the Users#edit action' do
        before { get edit_user_path(wrong_user) }
        specify { expect(response.body).not_to match(full_title('Edit user')) }
        specify { expect(response).to redirect_to(root_path) }
      end

      describe 'submitting a PATCH request to the Users#update action' do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_path) }
      end
    end

    describe 'as non-admin user' do
      before { sign_in user, no_capybara: true }

      describe 'submitting a DELETE request to the Users#destroy action', type: :request do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to root_path }
      end
    end

    describe 'user already has account' do
      before do
        sign_in user
        visit signup_path
      end

      it { should have_selector('div.alert.alert-notice') }
    end
  end
end
