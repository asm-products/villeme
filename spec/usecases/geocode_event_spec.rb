require 'rails_helper'
require_relative '../../app/domain/usecases/geolocalization/geocode_event'

describe 'UseCases::GeocodeEvent' do

  describe '.geocoded_by_address' do
    context 'when geocoded of event is realized with success' do
      it 'should return true' do
        event = build(:event, latitude: nil, longitude: nil, address: '544 Madison Ave, Albany, NY 12208, USA')

        result = Villeme::UseCases::GeocodeEvent.new(event).geocoded_by_address(event.address)

        expect(result).to be_truthy
      end
    end

    context 'when event DO NOT have a address' do
      it 'should return false' do
        event = build(:event, latitude: nil, longitude: nil, address: nil)

        result = Villeme::UseCases::GeocodeEvent.new(event).geocoded_by_address(event.address)

        expect(result).to be_falsey
      end
    end

  end

end