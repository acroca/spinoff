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

  describe ".tick" do
    it "increments time" do
      ConfigVariables[:time] = 1
      Slot.tick
      ConfigVariables[:time].to_i.should == 2
    end

    it "increments day and resets time" do
      ConfigVariables[:time] = 11
      ConfigVariables[:day] = 1
      Slot.tick
      ConfigVariables[:time].to_i.should == 0
      ConfigVariables[:day].to_i.should == 2
    end

    it 'checks audience for current time and day' do
      valid_slot = create(:slot, time: 1, day: 2)
      create(:slot, time: 1, day: 3)
      create(:slot, time: 2, day: 2)
      ConfigVariables[:time] = 1
      ConfigVariables[:day] = 2
      Audience.should_receive(:distribute).with(hash_including(slots: [valid_slot]))
      Slot.tick
    end
  end
end
