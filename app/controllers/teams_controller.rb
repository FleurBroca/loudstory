class TeamsController < ApplicationController

  before_action :set_team, only: [:show, :edit, :update, :destroy, :remove_user]

  def index
    @teams = current_user.teams
    @team = Team.new

  end

  def show
    session[:current_team_id] = @team.id
    redirect_to tracks_path
  end

  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.create(team_params)
    if current_user.save
      redirect_to team_path(@team)
      # redirect_to new_user_invitation_path

    else
      flash[:alert] = "This name is not available. Try a new one."
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to dashboards_index_path, notice: 'Team was successfully deleted.'
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end

end
