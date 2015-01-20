class DashboardsController < ApplicationController
  def index
    @user = current_user

    if not current_team.blank?
      @members = current_team.users
    end
  end

  def team_user_dashboard
    @user = User.find(params[:user_id])
    @team = Team.find(params[:team_id])
    @members = @team.users

    render :index
  end
end
