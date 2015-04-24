require 'rails_helper'
require_relative '../../app/domain/usecases/friends/get_friends'

describe 'UseCases::GetFriends' do

  describe '.friends_from_facebook_on_villeme' do
    it 'should return a first name of a friend from Facebook which stay on Villeme' do
      user = create(:user, name: 'Liselen de Avila Freitas', city_name: 'Canoas', address: 'Rua Carazinho, 456 - Canoas', token: 'CAAIEovVKmXYBAE1Ole2Jq0rvwBuQsCaZAa7svqllH1N4JHPqr8CT5SkMmP2VUhvZAr3TQlMXYLassq7p5OAgJaZCh4A7L7bBOg7sTYjgwy7FJOPQTMBYi1xCTlt91kZATIzbyLXhMxxTC0xp2Xca3oEenOYfPC3X2fHXPa1JTkJOR0IvK75s9vTLZB26ZB8u3wGD9DEgmZCNlQ6sKhRoGur')
             create(:user, name: 'Jonatas Eduardo Vedoi Salgado', city_name: 'Canoas', email: 'abc@email.com', address: 'Rua Carazinho, 456 - Canoas')
      city = create(:city, name: 'Canoas', address: 'Rua Carazinho, 456 - Canoas')
      allow(user).to receive(:city).and_return(city)

      result = Villeme::UseCases::GetFriends.friends_from_facebook_on_villeme(user)

      expect(result.first.name).to eq('Jonatas Eduardo Vedoi Salgado')
    end

  end

end