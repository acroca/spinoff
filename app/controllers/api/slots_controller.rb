class Api::SlotsController < ApiController
  def index
    @company = current_user.company
    @slots = @company.slots
    render :index
  end

  def show
    @company = current_user.company
    @slot = @company.slots.where(id: params[:id]).first
    unless @slot
      render nothing: true, status: 401
      return
    end
    render :show
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

  def update
    @slot = current_user.company.slots.where(id: params[:id]).first
    render(nothing: true, status: 401) && return unless @slot

    ad_contract = current_user.company.ad_contracts.where(id: params[:slot][:ad_contract_id]).first
    render(nothing: true, status: 401) && return unless ad_contract

    @slot.ad_contract = ad_contract
    if @slot.save
      render json: @slot
    else
      render json: @slot.errors, status: :unprocessable_entity
    end
  end
end
