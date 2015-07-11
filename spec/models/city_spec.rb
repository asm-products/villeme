require 'rails_helper'

describe City, type: :model do

  let(:city){ build(:city) }

  before(:each) do
    DatabaseCleaner.start
  end

  describe '#users' do
    it 'should return all users from this city' do
      create(:user, name: 'foo', email: 'foo@gmail.com', city_name: 'Albany', address: nil)
      create(:user, name: 'bar', email: 'bar@gmail.com', city_name: 'Albany', address: nil)
      create(:user, name: 'zaz', email: 'fuu@gmail.com', city_name: 'Atlanta', address: nil)

      expect(city.users.count).to eq(2)
    end
  end

  describe '#neighborhoods' do
    it 'should return a list of neighborhoods' do
      create(:neighborhood, city_name: 'Albany')
      create(:neighborhood, city_name: 'Albany')

      expect(city.neighborhoods.count).to eq(2)
    end
  end

  describe '#events' do
    it 'should return a list of events' do
      create(:event, name: 'Campus Party', city_name: 'Albany')
      create(:event, name: 'Hackaton', city_name: 'Albany')

      expect(city.events.count).to eq(2)
    end
  end

  after(:each) do
    DatabaseCleaner.clean
  end

end