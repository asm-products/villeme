require 'rails_helper'

describe Event, type: :model do

  describe '#neighborhood' do
    it 'should return neighborhood of event' do
      event = create(:event, neighborhood_name: 'Albany County')
      neighborhood = create(:neighborhood, name: 'Albany County')
                     create(:neighborhood, name: 'Bronx')

      expect(event.neighborhood).to eq(neighborhood)
    end
  end

end