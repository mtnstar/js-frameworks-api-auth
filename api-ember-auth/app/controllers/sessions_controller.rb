class SessionsController < ApplicationController

  skip_before_filter :authenticated?, only: :create
  skip_before_filter :verify_authenticity_token

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
  end

end
