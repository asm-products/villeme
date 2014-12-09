require 'rails_helper'

describe InvitesController, type: :controller do

  before(:each) do
    set_current_user_nil
  end

  describe 'POST create' do
    it 'should create an invite' do
      post :create, invite: attributes_for(:invite)

      expect(Invite.all.count).to eq(1)
    end

    it 'should redirect to welcome' do
      post :create, invite: attributes_for(:invite)

      expect(response).to redirect_to(welcome_path)
    end
  end

end