require 'rails_helper'
require_relative '../../app/domain/usecases/cities/get_city_slug'

describe 'UseCases::GetCitySlug' do

  before(:each) do
    @user = double('User')
  end

  context 'when user have a city' do

    before(:each) do
      allow(@user).to receive_message_chain(:city, :slug).and_return('sao-paulo')
    end

    it 'should return the slug of city' do
      result = Villeme::UseCases::GetCitySlug.from_user(@user)

      expect(result).to eq('sao-paulo')
    end

  end

  context 'when user DO NOT have a city' do

    before(:each) do
      allow(@user).to receive(:city).and_return(nil)
    end

    it 'should return false' do
      result = Villeme::UseCases::GetCitySlug.from_user(@user)

      expect(result).to  eq(nil)
    end

  end

  context 'when user DO NOT have a city.slug' do

    before(:each) do
      allow(@user).to receive_message_chain(:city, :slug).and_return(nil)
    end

    it 'should return false' do
      result = Villeme::UseCases::GetCitySlug.from_user(@user)

      expect(result).to eq(nil)
    end

  end

end