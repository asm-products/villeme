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

  describe '#mypersona' do

    context 'current_user logged in and invited' do

      before(:each) do
        set_user_logged_in
      end

      it 'should redirect to #index' do
        allow(@user).to receive_message_chain(:persona).and_return(create(:persona))
        allow(controller).to receive(:current_user){ @user }

        get :mypersona, locale: :en

        expect(response).to render_template(:index)
      end

    end

  end


  describe '#myagenda' do

    context 'current_user logged in and invited' do

      before(:each) do
        set_user_logged_in
      end

      it 'should redirect_to #index' do
        allow(@user).to receive_message_chain(:agenda_events, :upcoming).and_return(nil)

        get :myagenda, locale: :en

        expect(response).to render_template(:index)
      end

    end

  end


end