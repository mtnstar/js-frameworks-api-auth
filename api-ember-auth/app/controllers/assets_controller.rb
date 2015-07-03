class AssetsController < ApplicationController

  skip_before_filter :check_authorization

  protected
  def set_default_response_format
    request.format = :html
  end

end
