require 'rails_helper'
require_relative '../../app/domain/policies/geocoder/entity_geocoded'
require_relative '../../app/domain/usecases/geolocalization/geocode_invite'

describe 'UseCases::GeocodeInvite' do

  describe '.geocoded_by_address' do
    context 'when geocoded of invite is realized with success' do
      it 'should return true' do
        invite = build(:event, latitude: nil, longitude: nil, address: '544 Madison Ave, Albany, NY 12208, USA')
        invite_geocoded = Villeme::UseCases::GeocodeInvite.new(invite).geocoded_by_address(invite.address)

        result = Villeme::Policies::EntityGeocoded.is_geocoded?(invite_geocoded)

        expect(result).to be_truthy
      end
    end

    context 'when event DO NOT have a address' do
      it 'should return false' do
        invite = build(:event, latitude: nil, longitude: nil, address: nil)
        invite_geocoded = Villeme::UseCases::GeocodeInvite.new(invite).geocoded_by_address(invite.address)

        result = Villeme::Policies::EntityGeocoded.is_geocoded?(invite_geocoded)

        expect(result).to be_falsey
      end
    end

  end


end