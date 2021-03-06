class Api::V1::Users::SessionsController < Devise::SessionsController

  # prepend_before_action :require_no_authentication, :only => [:create ]
  skip_before_action :verify_authenticity_token
  include Devise::Controllers::Helpers
  
  before_action :ensure_params_exist

  respond_to :json
  
  def create
    # build_resource
    resource = User.find_for_database_authentication(:email=>params[:user_login][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:user_login][:password])
      sign_in("user", resource)
      render :json=> {:success=>true, :auth_token=>resource.jti, :email=>resource.email}
    else
      invalid_login_attempt
    end
  end
  
  def destroy
    sign_out(resource_name)
  end

  protected
  def ensure_params_exist
    return unless params[:user_login].blank?
    render :json=>{:success=>false, :message=>"missing user_login parameter"}, :status=>:unprocessable_entity
  end

  def invalid_login_attempt
    warden.custom_failure!
    render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>:unauthorized
  end

end
