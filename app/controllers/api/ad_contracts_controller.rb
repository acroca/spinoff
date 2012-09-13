class Api::AdContractsController < ApiController
  def index
    @ad_contracts = AdContract.available
    render :index
  end

  def show
    @company = current_user.company
    @ad_contract = @company.ad_contracts.where(id: params[:id]).first
    unless @ad_contract
      render nothing: true, status: 401
      return
    end
    render :show
  end

  def update
    ad_contract = AdContract.find(params[:id])
    if params[:ad_contract][:company_id]
      current_user.company.sign ad_contract
    end
    render json: ad_contract, status: 200
  end
end
