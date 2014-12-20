class AfterSignupController < Wicked::WizardController
  before_filter :authenticate_user!
  steps :add_project, :add_team

  def show
    @team = current_team
    render_wizard
  end

  def update
    @team = current_team
    @team.update_attributes(params[:team])
    render_wizard @team
  end

end
