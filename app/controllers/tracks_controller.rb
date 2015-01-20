class TracksController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @tracks = Track.all
    # @post = Post.find(params[:id])
  end

  def show
    @track = Track.find(params[:id])
    @exercises = @track.exercises.order(:position)
    @user = current_user
  end

  def new

  end

  private
  def track_params
    params.require(:track).permit(:title, :description, :photo)
  end
end
