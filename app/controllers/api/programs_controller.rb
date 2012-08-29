class Api::ProgramsController < ApiController
  def show
    @program = Program.find(params[:id])
  end

  def index
    @programs = Program.available
  end
end
