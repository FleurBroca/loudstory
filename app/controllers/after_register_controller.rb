class AfterRegisterController < Wicked::WizardController
  before_filter :authenticate_user!
  steps :add_project
  # :add_members

  def show
    case step
    when :add_project
    @user = current_user
    @team = Team.new
    when :add_members
    @team = Team.new
    end
    render_wizard
  end

  def update
    case step
    when :add_project
    @team = current_user.teams.create(team_params)
    render_wizard @team
    when :add_members
    @team = Team.find(params[:team][:id])
    User.invite!({:email => params[:email]}, current_user)
    render_wizard
    end
  end

  def finish_wizard_path
    tracks_path
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end

  def send_invitation
    begin
    invite_resource { |x| x.teams << current_team }
    yield resource if block_given?
    set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
    rescue
    self.resource = resource_class.new
    flash[:alert] = "This member is already on your team!"
  end
  end

end
