require 'rails_helper'

describe Event, type: :model do

  let(:event){ create(:event) }

  describe 'associations' do
    it { is_expected.to belong_to :place }
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :price }
    it { is_expected.to belong_to :persona }
    it { is_expected.to belong_to :subcategory }
    it { is_expected.to have_and_belong_to_many :categories }
    it { is_expected.to have_and_belong_to_many :weeks }
    it { is_expected.to have_many :agendas }
    it { is_expected.to have_many :agended_by }
    it { is_expected.to have_many :tips }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :date_start }
    it { is_expected.to validate_presence_of :hour_start_first }
    it { is_expected.to validate_presence_of :address }
  end

  describe '#create' do

    context 'event valid' do
      it 'should create event' do
        event = create(:event)

        event.save

        expect(event).to be_valid
      end
    end

    context 'event invalid' do
      it 'should NOT create event' do
        event = Event.new()

        event.save

        expect(event).to_not be_valid
      end
    end

  end

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

  describe '#place' do
    it 'should return a place from event' do
      create(:place, name: 'New York State Museum')
      create(:place, name: 'Cristo Redentor')

      expect(event.place.name).to eq('New York State Museum')
    end
  end

  describe '#name_with_limit' do
    it 'should return name of event with limit of chars' do
      event = create(:event, name: "This name of events have more than 45 chars for make this test testable")

      expect(event.name_with_limit.length).to eq(49)
    end
  end

  describe '#description_whit_limit' do
    it 'should return description of event with limit of chars' do
      event = create(:event, description: "This description of events have more than 70 chars for make this test testable testable")

      expect(event.description_with_limit.length).to eq(90)
    end
  end

end