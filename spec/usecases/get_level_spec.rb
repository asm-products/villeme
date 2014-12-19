require 'rails_helper'
require_relative '../../app/domain/usecases/level/get_level'

describe 'UseCase::GetLevel' do
  describe '.percentage_of_current_level' do
    context 'when DO NOT exist a level associated to user' do
      it 'should return 0' do
        user = double('User', level: nil)

        expect(Villeme::UseCases::GetLevel.percentage_of_current_level(user)).to eq 0
      end
    end

    context 'when user level DO NOT have points' do
      it 'should return 0' do
        user = double('User')
        user.stub_chain(:level, :points).and_return(nil)

        expect(Villeme::UseCases::GetLevel.percentage_of_current_level(user)).to eq 0
      end
    end
  end
end