require 'rails_helper'

describe 'Request an invite' do

  before do
    create(:persona)
  end

  context 'when user filled the valid data' do
    it 'should request a invite with success' do
      visit '/en'

      find('.invite.hidden-xs').click

      fill_in 'Name', with: 'John Doe'
      fill_in 'Email', with: 'johndoe@gmail.com'
      select 'Entrepreuner', from: 'invite_persona'
      fill_in 'Address', with: '544 Madison Ave, Albany, NY 12208, USA'

      click_button 'Confirm'

      expect(page).to have_content('sucesso')
    end
  end

  context 'when user DO NOT filled the valid data' do
    it 'should request a invite with success' do
      visit '/en'

      find('.invite.hidden-xs').click

      fill_in 'Name', with: 'John Doe'
      # fill_in 'email', with: 'johndoe@gmail.com'
      select 'Entrepreuner', from: 'invite_persona'
      fill_in 'Address', with: '544 Madison Ave, Albany, NY 12208, USA'

      click_button 'Confirm'

      expect(page).to have_content('Ops')
    end
  end

end