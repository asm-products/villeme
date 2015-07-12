require 'rails_helper'

describe UsersController do

  context 'when current_user is admin' do
    describe '#edit' do
      it 'should load page with success' do
        set_user_logged_in(id: 1, admin: true)

        get(:edit, {locale: :en, id: @user})

        expect(response.status).to eq(200)
      end
    end
  end

  context 'when current_user is NOT admin' do
    describe '#edit' do
      it 'should load page with success' do
        set_user_logged_in(id: 1, admin: false)

        get(:edit, {locale: :en, id: @user})

        expect(response).to redirect_to(root_path)
      end
    end
  end

end