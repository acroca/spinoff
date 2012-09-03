class Api::ProgramsController < ApiController
  def show
    @program = Program.find(params[:id])
  end

  def company_programs
    @company = Company.find(params[:id])
    @programs = @company.programs
    render :index
  end

  def index
    @programs = Program.available
  end

  def update
    program = Program.find(params[:id])
    if params[:program][:company_id]
      current_user.company.buy program
    end
    render json: program, status: 200
  end
end
