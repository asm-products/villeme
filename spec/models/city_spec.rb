require 'rails_helper'

describe City, type: :model do

  describe '#users' do
    it 'should return all users from this city' do
      @city = create(:city, name: 'New York')
      @users = []
      @users << create(:user, name: 'foo', email: 'foo@gmail.com', city_name: 'New York')
      @users << create(:user, name: 'bar', email: 'bar@gmail.com', city_name: 'New York')
      @users << create(:user, name: 'bar', email: 'fuu@gmail.com', city_name: 'Atlanta')

      expect(@city.users.count).to eq(2)
    end
  end

  describe '#neighborhoods' do
    it 'should return a list of neighborhoods' do
      @city = create(:city, name: 'New York')
      @neighborhoods = []
      @neighborhoods << create(:neighborhood, city_name: 'New York')
      @neighborhoods << create(:neighborhood, city_name: 'New York')

      expect(@city.neighborhoods).to eq(@neighborhoods)
    end
  end

end