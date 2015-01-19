require 'rails_helper'
require_relative '../../app/domain/usecases/cities/city_goal_decrease'

describe 'UseCases::CityGoalDecrease' do

  describe '#decrease' do
    before(:all) do
      @city = build(:city)
      @result = Villeme::UseCases::CityGoalDecrease.new(@city).decrease
    end
    it 'should decrease one unit in city goal attribute' do
      expect(@result).to eq(249)
    end
    it 'should save new goal in the city' do
      expect(@city.goal).to eq(249)
    end
  end

end