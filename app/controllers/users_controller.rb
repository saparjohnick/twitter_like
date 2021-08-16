class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :user_signed_in?, only: [:index, :create, :update, :delete, :following, :followers]

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

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

end
