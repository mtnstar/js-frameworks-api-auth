class SessionsController < ApplicationController

  skip_before_filter :check_authorization, only: :create

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      api_key = ApiKey.create(user: user)
      render json: api_key
    else
      render json: { errors: ['invalid user or password']}, status: :unauthorized
    end
  end

  def destroy
    client_id = extract_auth_header.first
    api_key = ApiKey.find_by(client_id: client_id)
    api_key.destroy!
    render json: { info: ['logged out successfully'] }
  end

end
