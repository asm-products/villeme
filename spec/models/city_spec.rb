require 'rails_helper'

describe City, type: :model do

  describe '#users' do

    it 'should return all users from this city' do
      @city = create(:city)
      @user = create(:user)

      expect(@city.users).to contain_exactly(@user)
    end

  end

end