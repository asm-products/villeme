require 'rails_helper'

describe WelcomeController, type: :controller do

  describe '#index' do

    context 'current_user logged in' do
      before(:each) do
        set_user_logged_in
        allow(@user).to receive_message_chain(:city, :slug).and_return(:ny)
        allow(controller).to receive(:current_user) { @user }
      end
      it 'should redirected to NewsfeedController#index' do
        get :index, locale: :en

        expect(response).to redirect_to("/#{@user.city.slug}")
      end
    end


    context 'current_user NOT logged in' do
      before(:each) do
        set_current_user_nil
      end

      it 'should load page with success' do
        get :index, locale: :en

        expect(response).to have_http_status(:success)
      end


      context 'current_user as a invite key' do
        it 'should active invite and create user' do
          invite = create(:invite)

          get :index, key: invite.key

          expect(response).to redirect_to('http://www.villeme.com/users/auth/facebook')
        end
      end

    end

  end
end