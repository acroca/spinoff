require 'spec_helper'

describe Slot do
  it { should allow_value(1).for(:day) }
  it { should_not allow_value(-1).for(:day) }

  it { should allow_value(0).for(:time) }
  it { should allow_value(11).for(:time) }
  it { should_not allow_value(12).for(:time) }
  it { should_not allow_value(-1).for(:time) }

  describe "creation in game time" do
    before do
      ConfigVariables[:time] = 5
      ConfigVariables[:day] = 5
    end

    it "allows past slots" do
      build(:slot, time: 6, day: 5).should be_valid
      build(:slot, time: 4, day: 6).should be_valid

      build(:slot, time: 4, day: 5).should_not be_valid
      build(:slot, time: 6, day: 4).should_not be_valid
    end
  end

  it 'is unique by company, day and time' do
    slot = create(:slot)
    build(:slot,
          company_id: slot.company_id,
          day: slot.day,
          time: slot.day).should_not be_valid
  end

  describe "#pay" do
    it 'adds money to the company based on the ad and audience' do
      ad_contract = create(:ad_contract, price: 20)
      slot = create(:slot, audience: 1000, ad_contract: ad_contract)
      company = slot.company

      expect{
        slot.pay!
      }.to change{company.reload.money}.by(20)
    end
  end
end
