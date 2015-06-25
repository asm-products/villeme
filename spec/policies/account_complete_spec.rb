require 'rails_helper'
require_relative '../../app/domain/policies/user/account_complete'

describe 'Policies::AccountComplete' do
  describe '.is_complete' do

    context 'When user is complete' do
      it 'should return true ' do
        user = double('User', attributes_for(:user))
        allow(user).to receive(:personas).and_return([1])

        result = Villeme::Policies::AccountComplete.is_complete?(user)

        expect(result).to be_truthy
      end
    end

    context 'When user is DO NOT have a name' do
      it 'should return false ' do
        user = double(attributes_for(:user, name: nil))
        allow(user).to receive(:persona_id).and_return(1)

        result = Villeme::Policies::AccountComplete.is_complete?(user)

        expect(result).to be_falsey
      end
    end

    context 'When user is DO NOT have a username' do
      it 'should return false ' do
        user = double(attributes_for(:user, username: nil))
        allow(user).to receive(:persona_id).and_return(1)

        result = Villeme::Policies::AccountComplete.is_complete?(user)

        expect(result).to be_falsey
      end
    end

    context 'When user is DO NOT have a email' do
      it 'should return false ' do
        user = double(attributes_for(:user, email: nil))
        allow(user).to receive(:persona_id).and_return(1)

        result = Villeme::Policies::AccountComplete.is_complete?(user)

        expect(result).to be_falsey
      end
    end

    context 'When user is DO NOT have a persona' do
      it 'should return false ' do
        user = double(attributes_for(:user))
        allow(user).to receive(:personas).and_return([])

        result = Villeme::Policies::AccountComplete.is_complete?(user)

        expect(result).to be_falsey
      end
    end

    context 'When user is DO NOT have a latitude' do
      it 'should return false ' do
        user = double(attributes_for(:user, latitude: nil))
        allow(user).to receive(:personas).and_return([1])

        result = Villeme::Policies::AccountComplete.is_complete?(user)

        expect(result).to be_falsey
      end
    end

    context 'When user is DO NOT have a longitude' do
      it 'should return false ' do
        user = double(attributes_for(:user, longitude: nil))
        allow(user).to receive(:personas).and_return([1])

        result = Villeme::Policies::AccountComplete.is_complete?(user)

        expect(result).to be_falsey
      end
    end

  end
end