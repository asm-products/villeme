require 'rails_helper'

describe NewsfeedController do

  describe '#index' do

    context 'current_user logged in and invited' do

      before(:each) do
        login_user
      end

      it 'should be load the page with success' do
        get :index, locale: :en

        expect(response.status).to eq(200)
      end
    end

    context 'current_user logged in and NOT invited' do
      it 'should be block access for user' do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = create(:user, invited: false)
        sign_in user

        get :index, locale: :en

        expect(response).to redirect_to(welcome_path)

      end
    end

  end

end