require 'rails_helper'

describe Neighborhood, type: :model do


  describe '#events' do
    it 'should return events from neighborhood' do
      neighborhood = create(:neighborhood, name: 'Park South')
      create(:event, name: 'Campus Party', neighborhood_name: 'Park South')
      create(:event, name: 'Hackathon', neighborhood_name: 'Park South')
      create(:event, name: 'Oktoberfest', neighborhood_name: 'Partenon', address: 'Rua Rivadavia Correia, 08 - Partenon Brasil')

      expect(neighborhood.events.size).to eq(2)
    end
  end

end