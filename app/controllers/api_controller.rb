class ApiController < ApplicationController
  respond_to :json

  before_filter :skip_trackable

  def skip_trackable
    request.env['devise.skip_trackable'] = true
  end

  def require_company
    render(text: "Company not created", status: 406) if current_user.company.nil?
  end

end
