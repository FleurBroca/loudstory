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
    if session[:landing] == 0
      session[:landing] = 1
      @vote = Vote.find(1)
      @vote.count_landing += 1
      @vote.save
      result = @vote.count_landing
      respond_to do |format|
        format.json { render :json => result.to_json }
      end
    else
      result
      respond_to do |format|
        format.json { render :nothing => true }
      end
    end
  end

  def count2
    if session[:press] == 0
      session[:press] = 1
      @vote = Vote.find(1)
      @vote.count_press += 1
      @vote.save
      result = @vote.count_press
      respond_to do |format|
        format.json { render :json => result.to_json }
      end
    else
      respond_to do |format|
        format.json { render :nothing => true }
      end
    end
  end

  def count3
    if session[:pitch] == 0
      session[:pitch] = 1
      @vote = Vote.find(1)
      @vote.count_pitch += 1
      @vote.save
      result = @vote.count_pitch
      respond_to do |format|
        format.json { render :json => result.to_json }
      end
    else
      respond_to do |format|
        format.json { render :nothing => true }
      end
    end
  end

  def votes
    @vote = Vote.find(1)
    session[:landing] = 0
    session[:press] = 0
    session[:pitch] = 0
  end

  private
  def track_params
    params.require(:track).permit(:title, :description, :photo)
  end
end
