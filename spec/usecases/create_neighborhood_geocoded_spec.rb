require 'rails_helper'
require_relative '../../app/domain/usecases/geolocalization/create_neighborhood_geocoded'

describe 'UseCases::CreateNeighborhoodGeocoded' do

  describe '.create_neighborhood' do

    before(:all) do
      address = '544 Madison Ave, Albany, NY 12208, USA'
      @result = Villeme::UseCases::CreateNeighborhoodGeocoded.new(address).create_neighborhood
    end

    context 'when a neighborhood DO NOT exist' do

      it 'should create a Neighborhood object' do
        expect(@result).to be_truthy
      end

      it 'should create a Neighborhood with Park South name' do
        expect(Neighborhood.last.name).to eq('Park South')
      end

      it 'should create a Neighborhood with New York state_name' do
        expect(Neighborhood.last.state_name).to eq('New York')
      end

      it 'should create a Neighborhood with NY state_code' do
        expect(Neighborhood.last.state_code).to eq('NY')
      end

      it 'should create a Neighborhood with country_name United States' do
        expect(Neighborhood.last.country_name).to eq('United States')
      end

      it 'should create a Neighborhood with country_code US' do
        expect(Neighborhood.last.country_code).to eq('US')
      end

      it 'should create a Neighborhood with latitude' do
        expect(Neighborhood.last.latitude).to be_kind_of(Float)
      end

      it 'should create a Neighborhood with longitude' do
        expect(Neighborhood.last.longitude).to be_kind_of(Float)
      end
    end

    context 'when a neighborhood exist' do

      before(:all) do
        address = '544 Madison Ave, Albany, NY 12208, USA'
        Villeme::UseCases::CreateNeighborhoodGeocoded.new(address).create_neighborhood
        @result = Villeme::UseCases::CreateNeighborhoodGeocoded.new(address).create_neighborhood
      end

      it 'should DO NOT create a Neighborhood object' do
        expect(@result).to be_falsey
      end
    end

  end

end