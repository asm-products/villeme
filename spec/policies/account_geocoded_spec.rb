require 'rails_helper'
require_relative '../../app/domain/policies/geocoder/entity_geocoded'

describe 'Policies::AccountGeocoded' do
  describe '.entity_geocoded' do

    context 'when entity have address, latitude and longitude' do
      it 'should return true' do
        entity = double('Entity', address: 'Address', latitude: 10.0000, longitude: 10.0000, country_name: 'United States')

        result = Villeme::Policies::EntityGeocoded.is_geocoded?(entity)

        expect(result).to be_truthy
      end
    end

    context 'when entity DO NOT have longitude' do
      it 'should return false' do
        entity = double('Entity', address: 'Address', latitude: 10.0000, longitude: nil, country_name: 'United States')

        result = Villeme::Policies::EntityGeocoded.is_geocoded?(entity)

        expect(result).to be_falsey
      end
    end


    context 'when entity DO NOT have latitude' do
      it 'should return false' do
        entity = double('Entity', address: 'Address', latitude: nil, longitude: 10.0000)

        result = Villeme::Policies::EntityGeocoded.is_geocoded?(entity)

        expect(result).to be_falsey
      end
    end

    context 'when entity DO NOT have address' do
      it 'should return false' do
        entity = double('Entity', address: nil, latitude: nil, longitude: 10.0000)

        result = Villeme::Policies::EntityGeocoded.is_geocoded?(entity)

        expect(result).to be_falsey
      end
    end

  end
end