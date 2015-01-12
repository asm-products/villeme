require 'rails_helper'
require_relative '../../app/domain/entities/week'

describe 'Entities::Week' do

  describe '.get_day_of_week' do
    it 'should return a first day of week' do
      result = Villeme::Entities::Week.new(1).get_day_of_week

      expect(result).to eq('Domingo')
    end

    it 'should return a last day of week' do
      result = Villeme::Entities::Week.new(7).get_day_of_week

      expect(result).to eq('Sábado')
    end
  end

end