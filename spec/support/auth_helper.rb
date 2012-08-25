module AuthHelper
  def http_login(email, password)
    request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(email, password)
  end
end
