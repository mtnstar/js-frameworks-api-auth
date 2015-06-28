class AssetsController < ApplicationController

  private
  # disable access restriction
  def authenticated?
    true
  end

end
