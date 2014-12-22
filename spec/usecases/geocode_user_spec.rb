require 'rails_helper'
require_relative '../../app/domain/usecases/geolocalization/geocode_user'
require_relative '../../app/domain/policies/geocoder/entity_geocoded'

describe 'UseCases::GeocodeUser' do

  describe '.geocoded_by_address' do
    context 'when geocoded of user is realized with success' do
      it 'should return true' do
        user = build(:user, latitude: nil, longitude: nil, address: '544 Madison Ave, Albany, NY 12208, USA')
        user_geocoded = Villeme::UseCases::GeocodeUser.new(user).geocoded_by_address(user.address)

        result = Villeme::Policies::EntityGeocoded.is_geocoded?(user_geocoded)

        expect(result).to be_truthy
      end
    end

    context 'when user DO NOT have a address' do
      it 'should return false' do
        user = build(:user, latitude: nil, longitude: nil, address: nil)
        user_geocoded = Villeme::UseCases::GeocodeUser.new(user).geocoded_by_address(user.address)

        result = Villeme::Policies::EntityGeocoded.is_geocoded?(user_geocoded)

        expect(result).to be_falsey
      end
    end

  end

end