require 'rails_helper'
require_relative '../../app/domain/usecases/level/points_level'

describe 'UseCases::PointsLevel' do

  describe '.points_to_next_level' do
    it 'should return 30 points left when user stay in level 1' do
      user =  build(:user)
              allow(user).to receive(:points).and_return(0)
      level = build(:level, name: 'Little Chicken', points: 30, nivel: 2)
              allow(user).to receive(:next_level).and_return(level)

      result = Villeme::UseCases::PointsLevel.points_to_next_level(user)

      expect(result).to eq(30)
    end

    it 'should return 12 points when user stay in level 1 with 18 points' do
      user  = build(:user)
              allow(user).to receive(:points).and_return(18)
      level = build(:level, name: 'Little Chicken', points: 30, nivel: 2)
              allow(user).to receive(:next_level).and_return(level)

      result = Villeme::UseCases::PointsLevel.points_to_next_level(user)

      expect(result).to eq(12)
    end

    it 'should return 10 points when user stay in level 2' do
      user  = build(:user)
              allow(user).to receive(:points).and_return(32)
      level = build(:level, name: 'Wood Hammer', points: 42, nivel: 3)
              allow(user).to receive(:next_level).and_return(level)

      result = Villeme::UseCases::PointsLevel.points_to_next_level(user)

      expect(result).to eq(10)
    end
  end

end