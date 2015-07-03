class ApiController < ApplicationController

  include Authentication
  before_action :set_default_response_format
  before_filter :check_authorization

  skip_before_filter :verify_authenticity_token

  protected
  def set_default_response_format
    request.format = :json
  end
end
