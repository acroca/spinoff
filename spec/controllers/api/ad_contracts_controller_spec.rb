require 'spec_helper'

describe Api::AdContractsController do
  describe "GET '/api/v1/ad_contracts'" do
    let(:user) { create(:user) }
    let!(:available_ad_contract) { create(:ad_contract) }
    let!(:signed_ad_contract) { create(:ad_contract, company_id: user.company.id) }

    def do_request
      get :index, format: 'json'
    end

    it "returns the ad_contract information" do
      do_request
      response.status.should == 200
      assigns(:ad_contracts).should_not be_nil
      response.should render_template("api/ad_contracts/index")
    end

    it "returns the company ad_contracts" do
      do_request
      ad_contracts = assigns(:ad_contracts)
      ad_contracts.should include(available_ad_contract)
      ad_contracts.should_not include(signed_ad_contract)
    end
  end

  describe "GET '/api/v1/ad_contracts/1'" do
    let(:user) { create(:user) }
    let!(:ad_contract) { create(:ad_contract, company_id: user.company.id) }

    before { sign_in user }

    def do_request(a)
      get :show, format: 'json', id: a.id
    end

    it "returns the ad_contract information" do
      do_request(ad_contract)
      response.status.should == 200
      assigns(:ad_contract).should == ad_contract
      response.should render_template("api/ad_contracts/show")
    end

    context "another ad_contract" do
      let!(:another_ad_contract) { create(:ad_contract) }
      it "returns the ad_contract information" do
        do_request(another_ad_contract)
        response.status.should == 401
      end
    end

  end

  describe "PUT '/api/v1/ad_contracts/1'" do
    let(:ad_contract) { create(:ad_contract) }
    let(:user) { create(:user) }

    before { sign_in user }

    def do_request(ad_contract_params)
      get :update, id: ad_contract.id, program: ad_contract_params, format: 'json'
    end

    it 'signs the ad_contract updating its company_id' do
      Company.any_instance.should_receive(:sign).with(ad_contract)
      do_request company_id: user.company.id
    end
  end
end
