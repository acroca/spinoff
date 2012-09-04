require 'spec_helper'

describe Slot do
  it { should allow_value(1).for(:day) }
  it { should_not allow_value(-1).for(:day) }

  it { should allow_value(0).for(:time) }
  it { should allow_value(11).for(:time) }
  it { should_not allow_value(12).for(:time) }
  it { should_not allow_value(-1).for(:time) }

  it 'is unique by company, day and time' do
    slot = create(:slot)
    build(:slot,
          company_id: slot.company_id,
          day: slot.day,
          time: slot.day).should_not be_valid
  end
end
