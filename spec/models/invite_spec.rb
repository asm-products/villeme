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

  describe '.geocoded_by_address' do
    let(:invite){ create(:invite) }

    it('should geocoded country') { expect(invite.country_code).to eq('US') }
    it('should geocoded state') { expect(invite.state_name).to eq('New York') }
    it('should geocoded city') { expect(invite.city_name).to eq('Albany') }
    it('should geocoded latitude') { expect(invite.latitude).to be_a_kind_of(Float) }
    it('should geocoded longitude') { expect(invite.longitude).to be_a_kind_of(Float) }
  end

  describe '#city' do
    it 'should return a city for invite' do
      invite = create(:invite, city_name: 'Albany')
      city = create(:city, name: 'Albany')

      expect(invite.city).to eq(city)
    end
  end

end