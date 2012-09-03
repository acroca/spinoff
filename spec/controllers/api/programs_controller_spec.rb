require 'spec_helper'

describe Api::ProgramsController do
  describe "GET '/api/v1/programs'" do
    let!(:available_program) { create(:movie, available: true) }
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

  describe "GET '/api/v1/company/2/programs'" do
    let!(:user) { create(:user) }
    let!(:user_program) { create(:movie, available: true, company: user.company ) }
    let!(:not_user_program) { create(:movie, available: false) }

    def do_request
      get :company_programs, id: user.company.id, format: 'json'
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
      programs.should include(user_program)
      programs.should_not include(not_user_program)
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

  describe "PUT '/api/v1/programs/1'" do
    let(:program) { create(:movie, available: true) }
    let(:user) { create(:user) }

    before { sign_in user }

    def do_request(program_params)
      get :update, id: program.id, program: program_params, format: 'json'
    end

    it 'buys the program updating its company_id' do
      Company.any_instance.should_receive(:buy).with(program)
      do_request company_id: user.company.id
    end
  end
end
