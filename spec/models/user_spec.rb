require 'rails_helper'

describe User, type: :model do

  describe '#neighborhood' do

    it 'should return neighborhood for user' do
      user = create(:user, neighborhood_name: 'Partenon')
      neighborhood = create(:neighborhood, name: 'Partenon')

      expect(user.neighborhood).to eq(neighborhood)
    end

  end

  describe '#country' do

    it 'should return country for user' do
      user = create(:user, country_name: 'United States')
      country = create(:country, name: 'United States')

      expect(user.country).to eq(country)
    end

  end

end