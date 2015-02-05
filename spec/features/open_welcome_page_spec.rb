require 'rails_helper'

describe 'Open the welcome page' do

  it 'should open the page with success' do
    visit '/en'

    expect(page).to have_title('Welcome to Villeme - Events and activities in your city')
  end

  it 'should open the welcome page in portuguese language' do
    visit '/pt-BR'

    expect(page).to have_title('Bem-vindo ao Villeme - Eventos e atividades na sua cidade!')
  end

end