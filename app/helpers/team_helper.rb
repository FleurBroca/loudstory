module TeamHelper
  def current_team
    @current_team ||= Team.find(params[:team_id])
  end
end
