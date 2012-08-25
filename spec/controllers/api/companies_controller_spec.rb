require 'spec_helper'

describe Api::CompaniesController do
  before { http_login(user.email, 'my_password') }

  describe "POST '/api/v1/company'" do
    let(:user) { create(:user) }
    let(:params) { {name: "Test company"} }
    def do_request
      post :create, params
    end

    it_behaves_like "an authenticated request"

    it "creates a company belonging to the user" do
      expect {
        do_request
      }.to change { user.reload.company }.from(nil).to(instance_of(Company))
    end
  end

  describe "GET '/api/v1/company'" do
    def do_request
      get :show, format: 'json'
    end

    let!(:user) { create(:user_with_company) }

    it_behaves_like "an authenticated request"
    it_behaves_like "a request that validates the company"

    it "returns the company information" do
      do_request
      response.status.should == 200
      assigns(:company).should == user.company
      response.should render_template("api/companies/show")
    end
  end
end
