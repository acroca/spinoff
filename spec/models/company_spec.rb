require 'spec_helper'

describe Company do
  it { should     allow_value('Company').for(:name)}
  it { should_not allow_value('   ').for(:name)}
  it { should_not allow_value('').for(:name)}
  it { should_not allow_value(nil).for(:name)}

  it { should     allow_value(60).for(:money) }
  it { should     allow_value(-1).for(:money) }
  it { should_not allow_value(nil).for(:money) }
  its(:money) { should == 100000 }

  it { should allow_value([create(:movie)]).for(:programs) }
  it { should allow_value([create(:documentary)]).for(:programs) }

  it 'allows only one company per user' do
    user = create(:user)

    company = Company.new(name: "something")
    company.should be_valid
    company.user = user
    company.should_not be_valid
  end

  describe ".buy" do
    let(:program) { create :movie, available: true, popularity: 100 }
    let(:company) { create(:user).company }

    it "gives the program to the company" do
      expect{
        company.buy(program)
      }.to change{company.reload.programs.include?(program)}.from(false).to(true)
    end

    it 'takes the money of the company' do
      expect{
        company.buy(program)
      }.to change{company.reload.money}.by(-program.price)
    end

    it "marks the program as not available" do
      expect{
        company.buy(program)
      }.to change{program.reload.available?}.from(true).to(false)
    end

    it 'returns true' do
      company.buy(program).should be_true
    end

    it 'notifies to Pusher' do
      channel = double
      Pusher.should_receive(:[]) { channel }
      channel.should_receive(:trigger).with('program-bought', program.id)
      company.buy(program)
    end

    context "with an unavailable program" do
      let(:program) { create :movie, available: false}

      it "does not give the program to the company" do
        expect{
          company.buy(program)
        }.to_not change{company.programs.include? program}
      end

      it "returns false" do
        company.buy(program).should be_false
      end
    end
  end

  describe ".sign" do
    let(:ad_contract) { create :ad_contract }
    let(:company) { create(:user).company }

    it "gives the ad to the company" do
      expect{
        company.sign(ad_contract)
      }.to change{company.reload.ad_contracts.include?(ad_contract)}.from(false).to(true)
    end

    it "marks the ad as not available" do
      expect{
        company.sign(ad_contract)
      }.to change{ad_contract.reload.available?}.from(true).to(false)
    end

    it 'returns true' do
      company.sign(ad_contract).should be_true
    end

    it 'notifies to Pusher' do
      channel = double
      Pusher.should_receive(:[]) { channel }
      channel.should_receive(:trigger).with('ad-contract-signed', ad_contract.id)
      company.sign(ad_contract)
    end

    context "with an unavailable ad" do
      let(:ad_contract) { create :ad_contract, company: create(:user).company }

      it "does not give the program to the company" do
        expect{
          company.sign(ad_contract)
        }.to_not change{company.ad_contracts.include? ad_contract}
      end

      it "returns false" do
        company.sign(ad_contract).should be_false
      end
    end
  end

end
