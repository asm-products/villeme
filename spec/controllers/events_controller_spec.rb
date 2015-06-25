require 'rails_helper'

describe EventsController do

  context 'when current user created the event' do
    describe '#edit' do
      it 'should load page with success' do
        set_user_logged_in(id: 1)
        event = create(:event, user_id: 1)

        get(:edit, {locale: :en, id: event})

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when current user DO NOT created the event' do
    describe '#edit' do
      it 'should load page with success' do
        set_user_logged_in(id: 1)
        event = create(:event, user_id: 2)

        get(:edit, {locale: :en, id: event})

        expect(response).to redirect_to(root_path)
      end
    end
  end

end