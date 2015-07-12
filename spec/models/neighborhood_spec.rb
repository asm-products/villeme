require 'rails_helper'

describe Neighborhood, type: :model do

  let(:neighborhood){ create(:neighborhood) }

  describe '#places' do
    it 'should return places from neighborhood' do
      create(:place, name: 'City Sandwich', neighborhood_name: 'Park South')
      create(:place, name: 'New York Museum', neighborhood_name: 'Park South')
      create(:place, name: 'Albany Central School', neighborhood_name: 'Park North', address: nil)

      expect(neighborhood.places.count).to eq(2)
    end
  end

  describe '#events' do
    it 'should return events from neighborhood' do
      neighborhood = build(:neighborhood, name: 'Pine Hills')

      create(:event, name: 'Campus Party', neighborhood_name: 'Pine Hills')
      create(:event, name: 'Hackathon', neighborhood_name: 'Pine Hills')
      create(:event, name: 'Oktoberfest', neighborhood_name: 'Mathias Velho', address: 'Rua Carazinho, 456 - Canoas')

      expect(neighborhood.events.count).to eq(2)
    end
  end

  describe '#city' do
    it 'should return city from neighborhood' do
      city = create(:city, name: 'Albany')

      expect(neighborhood.city).to eq(city)
    end
  end

  describe '#state' do
    it 'should return state from neighborhood' do
      state = create(:state, name: 'New York')

      expect(neighborhood.state).to eq(state)
    end
  end

  describe '#country' do
    it 'should return country from neighborhood' do
      country = create(:country, name: 'United States')

      expect(neighborhood.country).to eq(country)
    end
  end

end