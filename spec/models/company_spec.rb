require 'spec_helper'

describe Company do
  it { should     allow_value('Company').for(:name)}
  it { should_not allow_value('   ').for(:name)}
  it { should_not allow_value('').for(:name)}
  it { should_not allow_value(nil).for(:name)}

  it { should     allow_value(60).for(:money) }
  it { should     allow_value(-1).for(:money) }
  it { should_not allow_value(nil).for(:money) }
  its(:money) { should == 0 }

  it { should allow_value([create(:movie)]).for(:programs) }
  it { should allow_value([create(:documentary)]).for(:programs) }

  describe ".buy" do
    let(:program) { create :movie, available: true }
    let(:company) { create :company }

    it "gives the program to the company" do
      expect{
        company.buy(program)
      }.to change{company.programs.include?(program)}.from(false).to(true)
    end

    it "marks the program as not available" do
      expect{
        company.buy(program)
      }.to change{program.reload.available?}.from(true).to(false)
    end

    it 'returns true' do
      company.buy(program).should be_true
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

end
