require 'spec_helper'

describe AdContract do
  describe ".generate" do
    subject { AdContract.generate }

    it 'has a random advertiser name' do
      name = "Generatedname"
      AdContract.stub(:random_company_name) { name }
      subject.advertiser.should == name
    end

    it 'has a price of at least 10' do
      subject.price.should >= 10
    end

    it 'is available' do
      subject.should be_available
    end
  end
end
