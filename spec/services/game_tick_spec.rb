require 'spec_helper'

describe GameTick do
  describe ".tick" do
    it "increments time" do
      ConfigVariables[:time] = 1
      GameTick.perform
      ConfigVariables[:time].to_i.should == 2
    end

    it "increments day and resets time" do
      ConfigVariables[:time] = 11
      ConfigVariables[:day] = 1
      GameTick.perform
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
      GameTick.perform
    end

    it "pays everyone" do
      create(:slot, time: 1, day: 2)
      ConfigVariables[:time] = 1
      ConfigVariables[:day] = 2
      Slot.any_instance.should_receive(:pay!)
      GameTick.perform
    end

    it "publishes on Pusher" do
      ConfigVariables[:time] = 1
      ConfigVariables[:day] = 2

      channel = double
      Pusher.should_receive(:[]).with("spinoff") { channel }
      channel.should_receive(:trigger).with('game-tick', {time: 2, day: 2})

      GameTick.perform
    end
  end
end
