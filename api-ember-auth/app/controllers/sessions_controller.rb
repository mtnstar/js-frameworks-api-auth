class SessionsController < ApiController

  skip_before_filter :check_authorization, only: :create

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      @api_key = ApiKey.create(user: user)
      add_info 'login successful'
    else
      add_error 'invalid user or password'
      render status: :unauthorized
    end
  end

  def destroy
    client_id = extract_auth_header.first
    api_key = ApiKey.find_by(client_id: client_id)
    api_key.destroy!
    add_info 'logout successful'
  end

end
