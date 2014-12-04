require 'rails_helper'

describe Invite, type: :model do

  let(:invite){ create(:invite) }

  describe '#save' do
    subject { invite }
    it { is_expected.to be_truthy }
  end

  describe 'validations' do
    subject{ invite }
    it{ is_expected.to be_valid }
  end

end