require 'rails_helper'

describe User, type: :model do

  let(:user){ create(:user) }

  describe 'validations' do
    it{ is_expected.to belong_to :level }
  end

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

  describe '#distance_until' do
    it 'should return a distance from user to event' do
      user = create(:user)
      event = double('Event', attributes_for(:event))
      distance_result = {bus: "16", car: "8", walk: "8", bike: "9"}

      expect(user.distance_until(event, :minutes)).to eq(distance_result)
    end
  end

  describe '#events_from_neighborhood' do
    it 'should return events going in neighborhood of user' do
      events = []
      events << create(:event, name: 'Campus Party', neighborhood_name: 'Park South')
      events << create(:event, name: 'Hackathon', neighborhood_name: 'Park South')
      create(:neighborhood)

      expect(user.events_from_neighborhood).to eq(events)
    end
  end

  describe '#quantity_of_events_from_neighborhood' do
    it 'should return a number of events going in neighborhood of user' do
      create(:event, name: 'Campus Party', neighborhood_name: 'Park South')
      create(:event, name: 'Hackathon', neighborhood_name: 'Park South')
      create(:neighborhood)

      expect(user.quantity_of_events_from_neighborhood).to eq(2)
    end
  end

  describe '#events_from_persona' do
    it 'should return events from user persona' do
      user = create(:user, persona_id: 1)
      events = []
      events << create(:event, name: 'Campus Party', neighborhood_name: 'Park South', persona_id: 1)
      events << create(:event, name: 'Hackathon', neighborhood_name: 'Park South', persona_id: 1)

      expect(user.events_from_persona).to eq(events)
    end
  end

  describe '#quantity_of_events_from_persona' do
    it 'should return quantity of events from user persona' do
      user = create(:user, persona_id: 1)
      events = []
      events << create(:event, name: 'Campus Party', neighborhood_name: 'Park South', persona_id: 1)
      events << create(:event, name: 'Hackathon', neighborhood_name: 'Park South', persona_id: 1)

      expect(user.quantity_of_events_from_persona).to eq(2)
    end
  end

  describe '#next_level' do
    it 'should return next level' do
      create(:level, name: 'Ovo', points: 0, nivel: 1)
      create(:level, name: 'Pintinho', points: 30, nivel: 2)
      user.add_points(10)

      expect(user.next_level.nivel).to eq(2)
    end
  end

  describe '#points_to_next_level' do
    it 'should return points necessary to next level' do
      create(:level, name: 'Ovo', points: 0, nivel: 1)
      create(:level, name: 'Pintinho', points: 30, nivel: 2)
      user.add_points(10)

      expect(user.points_to_next_level).to eq(20)
    end
  end

end