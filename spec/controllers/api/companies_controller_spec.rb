require 'spec_helper'

describe Api::CompaniesController do
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
