require 'rails_helper'

describe Event, type: :model do

  let(:event){ create(:event) }

  describe '.geocoded_by_address' do
    it('should geocoded country') { expect(event.country_code).to eq('US') }
    it('should geocoded state') { expect(event.state_name).to eq('New York') }
    it('should geocoded city') { expect(event.city_name).to eq('Albany') }
    it('should geocoded latitude') { expect(event.latitude).to be_a_kind_of(Float) }
    it('should geocoded longitude') { expect(event.longitude).to be_a_kind_of(Float) }
  end

  describe '#country' do
    it 'should return country of event' do
      create(:country, name: 'United States')
      create(:country, name: 'Brazil')

      expect(event.country.name).to eq('United States')
    end
  end

  describe '#state' do
    it 'should return state of event' do
      create(:state, name: 'New York')
      create(:state, name: 'Florida')

      expect(event.state.name).to eq('New York')
    end
  end

  describe '#city' do
    it 'should return city of event' do
      create(:city, name: 'Albany')
      create(:city, name: 'Rio de Janeiro')

      expect(event.city.name).to eq('Albany')
    end
  end

  describe '#neighborhood' do
    it 'should return neighborhood of event' do
      create(:neighborhood, name: 'Park South')
      create(:neighborhood, name: 'Bronx')

      expect(event.neighborhood.name).to eq('Park South')
    end
  end


end