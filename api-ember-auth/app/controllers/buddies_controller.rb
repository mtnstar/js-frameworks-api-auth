class BuddiesController < ApplicationController

  def index
    @buddies = Buddy.all
  end

end
