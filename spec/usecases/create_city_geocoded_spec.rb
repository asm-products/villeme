require 'rails_helper'
require_relative '../../app/domain/usecases/geolocalization/create_city_geocoded'

describe 'UseCases::CreateCityGeocoded' do

  describe '.create_objects' do

    before(:all) do
      City.destroy_all
      address = '544 Madison Ave, Albany, NY 12208, USA'
      @result = Villeme::UseCases::CreateCityGeocoded.new(address).create_city
    end

    context 'when a city DO NOT exist' do

      it 'should create a City object' do
        expect(@result).to be_truthy
      end

      it 'should create a City with Albany name' do
        expect(City.last.name).to eq('Albany')
      end

      it 'should create a City with New York state_name' do
        expect(City.last.state_name).to eq('New York')
      end

      it 'should create a City with NY state_code' do
        expect(City.last.state_code).to eq('NY')
      end

      it 'should create a City with country_name United States' do
        expect(City.last.country_name).to eq('United States')
      end

      it 'should create a City with country_code US' do
        expect(City.last.country_code).to eq('US')
      end

      it 'should create a City with latitude' do
        expect(City.last.latitude).to be_kind_of(Float)
      end

      it 'should create a City with longitude' do
        expect(City.last.longitude).to be_kind_of(Float)
      end
    end

    context 'when a city exist' do

      before(:all) do
        address = '544 Madison Ave, Albany, NY 12208, USA'
        Villeme::UseCases::CreateCityGeocoded.new(address).create_city
        @result = Villeme::UseCases::CreateCityGeocoded.new(address).create_city
      end

      it 'should DO NOT create a City object' do
        expect(@result).to be_falsey
      end
    end

  end

end