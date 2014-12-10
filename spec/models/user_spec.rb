require 'rails_helper'

describe User, type: :model do

  let(:user){ create(:user) }

  describe '#neighborhood' do
    it 'should return neighborhood for user' do
      neighborhood = create(:neighborhood, name: 'Park South')

      expect(user.neighborhood).to eq(neighborhood)
    end
  end

  describe '#city' do
    it 'should return city for user' do
      city = create(:city)

      expect(user.city).to eq(city)
    end
  end

  describe '#state' do
    it 'should return state for user' do
      state = create(:state)

      expect(user.state).to eq(state)
    end
  end

  describe '#country' do
    it 'should return country for user' do
      country = create(:country, name: 'United States')

      expect(user.country).to eq(country)
    end
  end

  describe '#events' do
    it 'should return events belongs to user' do
      create(:event, name: 'Campus Party', user_id: 1)
      create(:event, name: 'Hackaton', user_id: 1)
      create(:event, name:'Octoberfest')

      expect(user.events.size).to eq(2)
    end
  end

end