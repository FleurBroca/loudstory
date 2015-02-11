class AfterRegisterController < Wicked::WizardController
  before_filter :authenticate_user!
  steps :add_project, :add_members, :how_it_works

  def show
    @user = current_user
    case step
    when :add_project
    @team = Team.new
    render_wizard nil, layout: "without_nav"
    when :add_members
    @team = current_team
    render_wizard
    when :how_it_works
    tracks_path
    render_wizard
    end
  end

  def update
    case step
    when :add_project
    @team = current_user.teams.create(team_params)
    if !@team.save
      flash[:alert] = "This name is not available. Try a new one."
    end
    render_wizard @team
    when :add_members
    @user = current_user
    User.invite!({:email => params[:email]}, current_user) do |u|
    u.teams << current_team
    end

    render_wizard @user
    end
  end

  def finish_wizard_path
    tracks_path
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end

  # def send_invitation
  #   begin
  #   invite_resource { |x| x.teams << current_team }
  #   yield resource if block_given?
  #   set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
  #   rescue
  #   self.resource = resource_class.new
  #   flash[:alert] = "This member is already on your team!"
  # end
  # end

end
