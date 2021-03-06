class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?

  prepend_view_path 'app/views/devise'

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end
