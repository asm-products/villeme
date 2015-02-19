require 'rails_helper'

describe 'Request an invite', js: true do

  before(:all) do
    I18n.locale = :en
    create(:persona)
  end

  context 'when user filled the valid data' do
    it 'should request a invite with success' do
      visit '/en'

      find('.Button.hidden-xs').click

      within '#new-invite' do
        fill_in 'invite[name]', with: 'John Doe'
        fill_in 'invite[email]', with: 'johndoe@gmail.com'
        select 'Entrepreneur', from: 'invite_persona'
        fill_in 'invite[address]', with: '544 Madison Ave, Albany, NY 12208, USA'
        click_button 'Confirm'
      end

      expect(page).to have_content(I18n.t('invite_create.valid', user_name: 'John'))
    end
  end

end