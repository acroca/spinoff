class Api::CompaniesController < ApiController

  before_filter :authenticate_user!, only: [:create]

  def create
    name = params["company"]['name']
    company = Company.new(name: name)
    company.user = current_user
    if company.valid?
      company.save!
      render json: company, status: 201
    else
      puts company.errors.inspect
      render nothing: true, status: 412
    end
  end

  def show
    @company = Company.find(params[:id])
  end
end
