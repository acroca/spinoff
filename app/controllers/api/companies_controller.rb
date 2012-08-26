class Api::CompaniesController < ApiController

  before_filter :require_company, except: [:create]

  def create
    name = params["company"]['name']
    company = Company.new(name: name)
    company.user = current_user
    if company.valid?
      company.save!
      render nothing: true, status: 201
    else
      puts company.errors.inspect
      render nothing: true, status: 412
    end
  end

  def show
    @company = current_user.company
  end
end
