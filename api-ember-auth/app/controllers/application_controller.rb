class ApplicationController < ActionController::Base

  before_filter :authenticated?

  private
  def authenticated?
      #ApiKey.exists?(access_token: token)
  end

  def auth_data
  end

  def authorization_header
    request.headers["Authorization"]
  end

  def request_uri
  end
end
