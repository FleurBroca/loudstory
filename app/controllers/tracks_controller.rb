class TracksController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def index
    @tracks = Track.all
    @post = Post.last
  end

  def show
    @track = Track.find(params[:id])
    @exercises = @track.exercises.order(:position)
    @user = current_user
  end

  def new

  end

  def count1
    #un vote par user
    @vote = Vote.find(1)
    @vote.count_landing += 1
    result = @vote.count_landing
    respond_to do |format|
      format.json { render :json => result.to_json }
    end
  end

  def count2
    @vote = Vote.find(1)
    @vote.count_press += 1
    result = @vote.count_press
    respond_to do |format|
      format.json { render :json => result.to_json }
    end
  end

  def count3
    @vote = Vote.find(1)
    @vote.count_pitch += 1
    result = @vote.count_pitch
    respond_to do |format|
      format.json { render :json => result.to_json }
    end
  end

  def votes

  end

  private
  def track_params
    params.require(:track).permit(:title, :description, :photo)
  end
end
