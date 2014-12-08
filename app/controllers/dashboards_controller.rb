class DashboardsController < ApplicationController
  def index
    @user = current_user
    @members = current_team.users
  end
end
