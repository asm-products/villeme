require 'rails_helper'

describe NewsfeedController do

  describe '#index' do
    context 'when current_user logged in, invited and have a #city_slug' do
      before(:each) do
        set_user_logged_in
        allow(@user).to receive(:city_slug).and_return(:albany)
        create(:city, name: 'Albany')
      end
      it 'should redirect to newsfeed#city' do
        get :index, locale: :en

        expect(response).to redirect_to(newsfeed_city_path(:albany))
      end
    end

    context 'when current_user logged, invited and DO NOT have a #city_slug' do
      before(:each) do
        set_user_logged_in({city_name: 'Rio de Janeiro'})
        allow(@user).to receive(:city_slug).and_return false
        @city = create(:city, name: 'Albany', launch: true)
               create(:city, name: 'Porto Alegre', launch: true)
      end
      it 'should be load the page with success' do
        get :index, locale: :en

        expect(response.status).to redirect_to(newsfeed_city_path(@city.slug))
      end
    end

    context 'current_user logged in and NOT invited' do
      before(:each) do
        set_user_logged_in_not_invited
        allow(controller).to receive(:current_user).and_return(@user)
        allow(@user).to receive(:city_slug).and_return(:albany)
        allow(@user).to receive(:invited).and_return(false)
      end
      it 'should be block access for user' do
        get :index, city: @user.city_slug, locale: :en

        expect(response).to redirect_to(welcome_path)
      end
    end

    context 'guest_user logged in and NOT invited' do
      before(:each) do
        @user = User.new(guest: true, email: "guest_#{Time.now.to_i}#{rand(100)}@example.com")
        allow(controller).to receive(:current_user).and_return(@user)
        allow(@user).to receive(:city_slug).and_return(:albany)
        allow(@user).to receive(:invited).and_return(false)
      end
      it 'should be block access for user' do
        get :index, city: @user.city_slug, locale: :en

        expect(response).to redirect_to(newsfeed_city_path(:albany))
      end
    end

  end

  describe '#mypersona' do

    context 'current_user logged in and invited' do

      before(:each) do
        set_user_logged_in
      end

      it 'should redirect to #index' do
        allow(@user).to receive(:persona).and_return(create(:persona))
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
        allow(@user).to receive_message_chain(:agenda_items, :upcoming).and_return(nil)

        get :myagenda, locale: :en

        expect(response.status).to eq(200)
      end

    end

  end


end