class DashboardsController < ApplicationController
  def index
    @user = current_user
    @members = current_team.users
  end

  def team_user_dashboard
    @user = User.find(params[:user_id])
    @team = Team.find(params[:team_id])
    @members = @team.users

    render :index
  end
end
