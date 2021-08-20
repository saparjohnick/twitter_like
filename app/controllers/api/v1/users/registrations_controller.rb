class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery except: :create
  respond_to :json
  def create

    user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if user.save
      render :json => { :token => user.jti, :email => user.email }, :status => :success
    else
      warden.custom_failure!
      render :json => user.errors, :status => :unprocessable_entity
    end
  end
end
