require 'rails_helper'
require_relative '../../app/domain/entities/week'

describe 'Entities::Week' do

  describe '.get_day_of_week' do
    before(:all) do
      I18n.locale = 'pt-BR'
    end

    it 'should return a first day of week' do
      result = Villeme::Entities::Week.get_day_by_id(1)

      expect(result).to eq('Domingo')
    end

    it 'should return a last day of week' do
      result = Villeme::Entities::Week.get_day_by_id(7)

      expect(result).to eq('Sábado')
    end
  end

end