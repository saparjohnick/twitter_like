class UsersController < ApplicationController
  # before_action :authenticate_user!
  before_action :authenticate_user!, only: [:index, :create, :update, :delete, :following, :followers]

  def new
  end

  def show
    @user = User.friendly.find(params[:id])
    @microposts = @user.microposts.page params[:page]
  end

  def destroy
    @user = authorize User.friendly.find(params[:id])
    @user && @user.destroy

    redirect_to root_url
    flash[:notice] = "User succesfully deleted."
  end

  def index
    @users = User.page params[:page] 
    @count = User.all.size
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.page params[:page]
    render 'show_follow'
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.page params[:page]
    render 'show_follow'
  end

end
