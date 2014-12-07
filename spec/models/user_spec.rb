require 'rails_helper'

describe User, type: :model do

  describe '#neighborhood' do
    it 'should return neighborhood for user' do
      user = create(:user, neighborhood_name: 'Partenon')
      neighborhood = create(:neighborhood, name: 'Partenon')

      expect(user.neighborhood).to eq(neighborhood)
    end
  end

  describe '#city' do
    it 'should return city for user' do
      user = create(:user)
      city = create(:city)

      expect(user.city).to eq(city)
    end
  end

  describe '#state' do
    it 'should return state for user' do
      user = create(:user)
      state = create(:state)

      expect(user.state).to eq(state)
    end
  end

  describe '#country' do
    it 'should return country for user' do
      user = create(:user, country_name: 'United States')
      country = create(:country, name: 'United States')

      expect(user.country).to eq(country)
    end
  end

  describe '#events' do
    it 'should return events belongs to user' do
      user = create(:user)
      events = [create(:event, name: 'Campus Party', user_id: 1),
                create(:event, name: 'Hackaton', user_id: 1)]
                create(:event, name:'Octoberfest')

      expect(user.events).to eq(events)
    end
  end

end