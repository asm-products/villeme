require 'rspec'
require 'rails_helper'

describe WelcomeController, type: :controller do

  describe '#index' do
    it "should load with success" do

      user = User.new
      allow(controller).to receive(:current_user).and_return(user)

      get :index, locale: :en
      expect(response.status).to eq(200)
    end
  end

end