require 'rails_helper'

describe NewsfeedController do

  describe '#index' do
    context 'current_user logged in and invited' do
      before(:each) do
        set_user_logged_in
        allow(@user).to receive(:city_slug).and_return(:albany)
        create(:city, name: 'Albany')
      end
      it 'should be load the page with success' do
        get :index, city: @user.city_slug, locale: :en

        expect(response.status).to eq(200)
      end
    end

    context 'current_user logged in and NOT invited' do
      before(:each) do
        set_current_user_nil
        allow(@user).to receive(:city_slug).and_return(:albany)
      end
      it 'should be block access for user' do
        get :index, city: @user.city_slug, locale: :en

        expect(response).to redirect_to(welcome_path)
      end
    end

    context 'current_user logged in, invited and DO NOT have a city_slug' do
      before(:each) do
        set_user_logged_in
        allow(@user).to receive(:city_slug).and_return('newsfeed')
      end
      it 'should redirect to account edit' do
        get :index, locale: :en

        expect(response.status).to eq(200)
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