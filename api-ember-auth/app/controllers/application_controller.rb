class ApplicationController < ActionController::Base

  include Authentication

  skip_before_filter :verify_authenticity_token

end
