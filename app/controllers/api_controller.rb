class ApiController < ApplicationController
  respond_to :json

  def require_company
    render(text: "Company not created", status: 406) if current_user.company.nil?
  end

  def current_user
    @user
  end

end
