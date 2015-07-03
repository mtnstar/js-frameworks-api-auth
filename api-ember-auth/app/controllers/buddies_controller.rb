class BuddiesController < ApiController

  def index
    @buddies = Buddy.all
  end

end
