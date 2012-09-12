class Api::AdContractsController < ApiController
  def index
    @company = current_user.company
    @ad_contracts = @company.ad_contracts
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
    if params[:program][:company_id]
      current_user.company.sign ad_contract
    end
    render json: ad_contract, status: 200
  end
end
