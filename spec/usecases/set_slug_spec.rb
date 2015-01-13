require 'rails_helper'
require_relative '../../app/domain/usecases/users/set_slug'

describe 'UseCases::GetSlug' do

  describe '.to_slug' do
    it 'should return a text slugged' do
      result = Villeme::UseCases::SetSlug.to_slug('Jonatas Eduardo Vedoi Salgado')

      expect(result).to eq('jonatas-eduardo-vedoi-salgado')
    end
  end

end