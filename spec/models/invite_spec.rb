require 'rails_helper'

describe Invite, type: :model do


  describe '#save' do
    let(:invite){ create(:invite) }
    subject { invite }
    it { is_expected.to be_truthy }
  end

  describe 'validations' do
    let(:invite){ create(:invite) }
    subject{ invite }
    it{ is_expected.to be_valid }
  end

  describe '#city' do
    it 'should return a city for invite' do
      invite = create(:invite, city_name: 'Albany')
      city = create(:city, name: 'Albany')

      expect(invite.city).to eq(city)
    end
  end

end