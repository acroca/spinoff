class ApiController < ApplicationController
  respond_to :json

  before_filter :login_user

  def require_company
    render(text: "Company not created", status: 406) if current_user.company.nil?
  end

  def current_user
    @user
  end

  def login_user
    authenticate_or_request_with_http_basic("Application") do |name, password|
      @user = User.login(name, password)
      @user.present?
    end
  end

end
