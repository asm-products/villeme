require 'rails_helper'

describe 'Edit an event' do

  context 'when current user DO NOT create the event' do
    it 'should open the page with success' do
      user = create(:user)
             login_as(user, :scope => :user)
      event = create(:event)

      visit("events/#{event.id}/edit")

      expect(page).to have_content('Ops!')
    end
  end

  context 'when current user create the event' do
    it 'should open the page with success' do
      user = create(:user, id: 1)
             login_as(user, :scope => :user)
      event = create(:event, user_id: 1)

      visit("events/#{event.id}/edit")

      expect(page).to have_content(event.name)
    end
  end

  after(:each) do
    Warden.test_reset!
  end

end