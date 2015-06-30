class ApplicationController < ActionController::Base

  include Authentication
  before_filter :check_authorization

  skip_before_filter :verify_authenticity_token

end
