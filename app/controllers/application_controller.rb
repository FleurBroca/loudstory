class ApplicationController < ActionController::Base
  # include Pundit
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protect_from_forgery with: :exception
  before_action :authenticate_user!, :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  # after_action :verify_authorized, :except => :index, unless: :devise_controller?
  # after_action :verify_policy_scoped, :only => :index, unless: :devise_controller?

  helper_method :current_team

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  private
   def configure_permitted_parameters
     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :team, :email, :password, :password_confirmation) }
     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :team, :email, :password, :password_confirmation, :current_password, :picture) }
   end

   def current_team
    @current_team ||= (session[:current_team_id] &&
      current_user.teams.find_by(id: session[:current_team_id])) ||
      current_user.teams.first
   end

   def user_not_authorized
     flash[:alert] = "You are not authorized to perform this action."
     redirect_to(root_path)
   end

end
