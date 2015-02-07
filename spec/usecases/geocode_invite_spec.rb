require 'rails_helper'
require_relative '../../app/domain/policies/geocoder/entity_geocoded'
require_relative '../../app/domain/usecases/geolocalization/geocode_invite'

describe 'UseCases::GeocodeInvite' do

  describe '.geocoded_by_address' do
    context 'when geocoded of invite is realized with success' do
      before(:each) do
        @invite = create(:invite, name: 'John Doe', email: 'teste@gmail.com', address: 'Rua Carazinho, 456 - Canoas', persona: 'Entrepreneur', latitude: nil, longitude: nil)
      end

      it 'should return true if invites is geocoded' do
        result = Villeme::Policies::EntityGeocoded.is_geocoded?(@invite)

        expect(result).to be_truthy
      end

      it 'should create a city from invite address' do
        expect(@invite.city.name).to eq('Canoas')
      end
    end

    context 'when event DO NOT have a address' do
      it 'should return false' do
        invite = build(:invite, latitude: nil, longitude: nil, address: nil)

        result = Villeme::Policies::EntityGeocoded.is_geocoded?(invite)

        expect(result).to be_falsey
      end
    end

  end


end