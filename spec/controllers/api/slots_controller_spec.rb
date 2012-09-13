require 'spec_helper'

describe Api::SlotsController do
  describe "GET '/api/v1/slots'" do
    let(:user) { create(:user) }
    let!(:company_slot) { create(:slot, company_id: user.company.id) }
    let!(:other_slot) { create(:slot) }

    before { sign_in user }

    def do_request
      get :index, format: 'json'
    end

    it "returns the slot information" do
      do_request
      response.status.should == 200
      assigns(:slots).should_not be_nil
      response.should render_template("api/slots/index")
    end

    it "returns the company slots" do
      do_request
      slots = assigns(:slots)
      slots.should include(company_slot)
      slots.should_not include(other_slot)
    end
  end

  describe "GET '/api/v1/slots/1'" do
    let(:user) { create(:user) }
    let!(:slot) { create(:slot, company_id: user.company.id) }

    before { sign_in user }

    def do_request(s)
      get :show, format: 'json', id: s.id
    end

    it "returns the slot information" do
      do_request(slot)
      response.status.should == 200
      assigns(:slot).should == slot
      response.should render_template("api/slots/show")
    end

    context "another slot" do
      let!(:another_slot) { create(:slot) }
      it "returns the slot information" do
        do_request(another_slot)
        response.status.should == 401
      end
    end

  end

  describe "POST '/api/v1/slots'" do
    let(:user) { create(:user) }

    before { sign_in user }

    def do_request(slot_params)
      post :create, slot: slot_params, format: 'json'
    end

    it 'creates the slot' do
      expect {
        do_request day: 1, time: 1
      }.to change { Slot.count }.by(1)
    end
  end

  describe "PUT '/api/v1/slots/1'" do
    let(:user) { create(:user) }
    let(:program) { create(:movie, company: user.company) }
    let(:slot) { create(:slot, company: user.company, program: program) }
    let(:ad_contract) { create(:ad_contract, company: user.company) }

    before { sign_in user }

    def do_request(slot_params)
      put :update, id: slot.id, slot: slot_params, format: 'json'
    end

    it 'sets the ad_contract to the slot' do
      expect {
        do_request ad_contract_id: ad_contract.id
      }.to change { slot.reload.ad_contract }.from(nil).to(ad_contract)
    end

    context "with another user's slot" do
      let(:slot) { create(:slot) }
      it "doesn't set the ad" do
        expect {
          do_request ad_contract_id: ad_contract.id
        }.to_not change { slot.reload.ad_contract }
      end
    end

    context "with another user's ad" do
      let(:ad_contract) { create(:ad_contract) }
      it "doesn't set the ad" do
        expect {
          do_request ad_contract_id: ad_contract.id
        }.to_not change { slot.reload.ad_contract }
      end
    end

  end
end
