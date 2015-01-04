class Auth::RegistrationsController < Devise::RegistrationsController

  def create
    super
  end

  protected
  def after_sign_up_path_for(resource)
    # new_team_path
    after_register_path(:add_project)
  end

  def after_sign_in_path_for(resource)
    tracks_path
  end
end