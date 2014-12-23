require 'rails_helper'

describe '/city/:city' do
  context 'when user have a city_slug' do
    it 'should load current_user city' do
      user = double("User")
      create(:city)
      allow(user).to receive(:city_slug).and_return('albany')

      expect(get: "city/#{user.city_slug}").to route_to(controller: 'newsfeed',
                                                        action: 'city',
                                                        city: 'albany'
                                               )
    end
  end

  context 'when user DO NOT have a city_slug' do
    it 'should load city default' do
      user = double("User")
      allow(user).to receive(:city_slug).and_return('newsfeed')

      expect(get: "city/#{user.city_slug}").to route_to(controller: 'newsfeed',
                                                        action: 'city',
                                                        city: user.city_slug
                                                        )
    end
  end

end


