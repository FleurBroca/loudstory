class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @tracks = Track.all
    @post = Post.last
  end

  def pricing
  end

end