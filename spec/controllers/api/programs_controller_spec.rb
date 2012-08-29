require 'spec_helper'

describe Api::ProgramsController do
  describe "GET '/api/v1/programs'" do
    let!(:available_program)     { create(:movie, available: true) }
    let!(:unavailable_program) { create(:movie, available: false) }

    def do_request
      get :index, format: 'json'
    end

    it "returns the program information" do
      do_request
      response.status.should == 200
      assigns(:programs).should_not be_nil
      response.should render_template("api/programs/index")
    end

    it "returns available programs" do
      do_request
      programs = assigns(:programs)
      programs.should include(available_program)
      programs.should_not include(unavailable_program)
    end
  end

  describe "GET '/api/v1/programs/1'" do
    let(:program) { create(:movie) }

    def do_request
      get :show, id: program.id, format: 'json'
    end

    it "returns the program information" do
      do_request
      response.status.should == 200
      assigns(:program).should == program
      response.should render_template("api/programs/show")
    end
  end
end
