class ApiController < ApplicationController

  include Authentication

  before_filter :init_messages
  before_filter :check_authorization

  before_action :set_default_response_format

  skip_before_filter :verify_authenticity_token

  protected
  def set_default_response_format
    request.format = :json
  end

  def add_error(msg)
    @messages[:error] << msg
  end

  def add_info(msg)
    @messages[:info] << msg
  end

  private
  def init_messages
    @messages = {}
    @messages[:error] = []
    @messages[:info] = []
  end
end
