require 'rails_helper'

describe NewsfeedController do

  describe '#index' do

    context 'current_user logged in' do
      it 'should be load the page with success' do
        user = build(:user)
        allow(controller).to receive(:current_user).and_return(user)

        get :index, locale: :en

        expect(response.status).to eq(200)
      end
    end

    context 'current_user NOT logged in' do
    end

  end

end