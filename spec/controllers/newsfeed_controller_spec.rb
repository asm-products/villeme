require 'rails_helper'

describe NewsfeedController do

  describe '#index' do

    context 'current_user logged in and invited' do

      before(:each) do
        set_user_logged_in
      end

      it 'should be load the page with success' do
        get :index, locale: :en

        expect(response.status).to eq(200)
      end
    end

    context 'current_user logged in and NOT invited' do

      before(:each) do
        set_current_user_nil
      end

      it 'should be block access for user' do
        get :index, locale: :en

        expect(response).to redirect_to(welcome_path)

      end
    end

  end

end