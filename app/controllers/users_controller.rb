class UsersController < ApplicationController

  def new
  end

  def show
    @user = User.friendly.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def destroy
    @user = User.friendly.find(params[:id])
    if @user.present?
      @user.destroy
    end
    redirect_to root_url
    flash[:notice] = "User succesfully deleted."
  end

  def index
    @users = User.paginate(page: params[:page])
    @count = User.all.size
  end

end
