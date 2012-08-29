class Api::CompaniesController < ApiController
  def show
    @company = Company.find(params[:id])
  end
end
