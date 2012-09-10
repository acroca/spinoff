class Api::SlotsController < ApiController
  def index
    @company = current_user.company
    @slots = @company.slots
    render :index
  end

  def create
    @slot = Slot.new params[:slot].extract!(:day, :time, :program_id)
    @slot.company = current_user.company
    if @slot.save
      render :show, status: :created
    else
      render json: @slot.errors, status: :unprocessable_entity
    end
  end
end
