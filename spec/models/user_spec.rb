require 'spec_helper'

describe User do
  it 'has a company' do
    create(:user).company.should be_a_kind_of(Company)
  end

  it 'creates its company' do
    expect {
      create(:user, company_name: 'Test company')
    }.to change { Company.count }.by(1)
  end

  it "does not create the user if the company can't be created" do
    expect {
      expect {
        create(:user, company_name: '')
      }.to raise_error(ActiveRecord::RecordInvalid)
    }.to_not change { User.count }
  end
end
