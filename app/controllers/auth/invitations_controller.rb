class Auth::InvitationsController < Devise::InvitationsController

  # POST /resource/invitation
  def create
    begin
      invite_resource { |x| x.teams << current_team }
      yield resource if block_given?
      set_flash_message :notice, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
      respond_with resource, :location => after_invite_path_for(resource)
    rescue
      self.resource = resource_class.new
      flash[:alert] = "Le mec a deja ete invite"
      respond_with_navigational(resource) { render :new }
    end
  end

  protected

  def configure_permitted_parameters
    # Only add some parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:first_name, :last_name]
  end

end
