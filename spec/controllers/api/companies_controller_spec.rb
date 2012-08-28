require 'spec_helper'

describe Api::CompaniesController do

  describe "POST '/api/v1/company'" do
    before { http_login(user.email, 'my_password') }

    let(:user) { create(:user) }
    let(:params) { {company: {name: "Test company"}} }
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

  describe "GET '/api/v1/companies/1'" do
    let(:company) { create(:company) }
    def do_request
      get :show, id: company.id, format: 'json'
    end

    it "returns the company information" do
      do_request
      response.status.should == 200
      assigns(:company).should == company
      response.should render_template("api/companies/show")
    end
  end
end
