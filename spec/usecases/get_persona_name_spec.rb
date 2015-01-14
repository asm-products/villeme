require 'rails_helper'
require_relative '../../app/domain/usecases/personas/get_persona_name'

describe 'UseCases::GetPersona' do

  describe '.find_by_id' do
    it 'should return Entrepreuner' do
      result = Villeme::UseCases::GetPersonaName.find_by_id(1)

      expect(result).to eq('Entrepreuner')
    end

    it 'should return alert of do not exist persona id' do
      result = Villeme::UseCases::GetPersonaName.find_by_id(10)

      expect(result).to eq('Without persona')
    end

  end

end