require 'rails_helper'

describe Event, type: :model do

  let(:event){ create(:event) }

  describe '#country' do
    it 'should return country of event' do
      country = create(:country)
                create(:country)

      expect(event.country).to eq(country)
    end
  end

  describe '#neighborhood' do
    it 'should return neighborhood of event' do
      neighborhood = create(:neighborhood, name: 'Albany County')
                     create(:neighborhood, name: 'Bronx')

      expect(event.neighborhood).to eq(neighborhood)
    end
  end

  describe '#city' do
    it 'should return city of event' do
      city = create(:city, name: 'Albany')
             create(:city, name: 'Rio de Janeiro')

      expect(event.city).to eq(city)
    end
  end

end