require 'rails_helper'

describe EventsController do

  describe '#edit' do
    it 'should load page with success' do
      set_user_logged_in
      event = create(:event)

      get(:edit, {locale: :en, id: event})

      expect(response.status).to eq(200)
    end
  end

end