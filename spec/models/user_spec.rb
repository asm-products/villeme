require 'rails_helper'

describe User, type: :model do

  describe '#neighborhood' do

    it 'should return neighborhood for user' do
      user = create(:user, neighborhood_name: 'Partenon')
      neighborhood = create(:neighborhood, name: 'Partenon')

      expect(user.neighborhood).to eq(neighborhood)
    end

  end

end