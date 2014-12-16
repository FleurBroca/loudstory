class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def remove_from_team
    team = Team.find(params[:team_id])
    user = team.users.find(params[:id])
    team.users.delete(user)
    redirect_to dashboards_index_path
  end
end