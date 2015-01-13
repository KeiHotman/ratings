require 'rails_helper'

RSpec.describe UsersSimilarity, :type => :model do
  describe "#valid?" do
    it { expect(FactoryGirl.build(:user)).to be_valid }
    it { expect(FactoryGirl.build(:invalid_user)).to be_invalid }
  end
end
