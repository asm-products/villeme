require 'rails_helper'

describe Neighborhood, type: :model do

  let(:neighborhood){ create(:neighborhood) }

  describe '#events' do
    it 'should return events from neighborhood' do
      events = [create(:event, name: 'Campus Party'),
                create(:event, name: 'Hackathon')]
      create(:event, name: 'Oktoberfest', neighborhood_name: 'Partenon')

      expect(neighborhood.events).to eq(events)
    end
  end

end