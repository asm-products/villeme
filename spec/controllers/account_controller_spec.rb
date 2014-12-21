require 'rails_helper'

describe AccountsController, type: :controller do

  describe '#update' do
    context 'when user is logged in' do

      before(:each) do
        set_user_logged_in
      end

      it 'should redirect to newsfeed' do
        put :update, id: @user.id, user: @user.attributes

        expect(response).to redirect_to(newsfeed_path)
      end

    end

    context 'when user is NOT logged in' do

      before(:each) do
        set_current_user_nil
      end

      it 'should do something' do
        put :update, id: 1, user: nil

        expect(response).to redirect_to(welcome_path)
      end

    end
  end

end