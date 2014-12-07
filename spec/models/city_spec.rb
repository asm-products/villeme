require 'rails_helper'

describe City, type: :model do

  let(:city){ create(:city) }

  describe '#users' do
    it 'should return all users from this city' do
      @users = []
      @users << create(:user, name: 'foo', email: 'foo@gmail.com', city_name: 'Albany')
      @users << create(:user, name: 'bar', email: 'bar@gmail.com', city_name: 'Albany')
      @users << create(:user, name: 'bar', email: 'fuu@gmail.com', city_name: 'Atlanta')

      expect(city.users.count).to eq(2)
    end
  end

  describe '#neighborhoods' do
    it 'should return a list of neighborhoods' do
      @neighborhoods = []
      @neighborhoods << create(:neighborhood, city_name: 'Albany')
      @neighborhoods << create(:neighborhood, city_name: 'Albany')

      expect(city.neighborhoods).to eq(@neighborhoods)
    end
  end

  describe '#events' do
    it 'should return a list of events' do
      @events = []
      @events << create(:event, name: 'Campus Party', city_name: 'Albany')
      @events << create(:event, name: 'Hackaton', city_name: 'Albany')

      expect(city.events).to eq(@events)
    end
  end

end