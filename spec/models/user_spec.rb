require 'rails_helper'
require_relative '../../app/domain/policies/geocoder/entity_geocoded'

describe User, type: :model do

  let(:user){ create(:user) }

  describe 'associations' do
    it{ is_expected.to belong_to :level }
    it{ is_expected.to belong_to :persona }
    it{ is_expected.to have_one :notify }
    it{ is_expected.to have_many :events }
    it{ is_expected.to have_many :feedbacks }
    it{ is_expected.to have_many :tips }
    it{ is_expected.to have_many :agendas }
    it{ is_expected.to have_many :agenda_events }
    it{ is_expected.to have_many :friendships }
    it{ is_expected.to have_many :friends }
    it{ is_expected.to have_many :accepted_friends }
    it{ is_expected.to have_many :requested_friendships }
    it{ is_expected.to have_many :requested_friends }
    it{ is_expected.to have_many :pending_friendships }
    it{ is_expected.to have_many :pending_friends }
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

  describe '#distance_until' do
    it 'should return a distance from user to event' do
      event = double('Event', attributes_for(:event))
      result = user.distance_until(event, :minutes)

      expect(result[:bus].to_i).to be_between(12, 14)
      expect(result[:car].to_i).to be_between(4, 6)
      expect(result[:walk].to_i).to be_between(4, 6)
      expect(result[:bike].to_i).to be_between(3, 6)
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

  describe '#percentage_of_current_level' do
    it 'should return percentage completed of current level' do
      create(:level, name: 'Ovo', points: 0, nivel: 1)
      create(:level, name: 'Pintinho', points: 30, nivel: 2)
      user.add_points(10)

      expect(user.percentage_of_current_level).to eq(33)
    end
  end

  describe '#geocode_event' do
    it 'should geocode event' do
      event = create(:event, latitude: nil, longitude: nil)
      event_geocoded = Villeme::UseCases::GeocodeEvent.new(event).geocoded_by_address(event.address)

      result = Villeme::Policies::EntityGeocoded.is_geocoded?(event_geocoded)

      expect(result).to be_truthy
    end
  end


end