class MicropostsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created."
      redirect_to root_url
    else 
      render 'static_pages/home'
    end
  end

  def destroy
    if @micropost.present?
      @micropost.destroy!
    end
    redirect_to root_url
    flash[:success] = "Micropost deleted."
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find(params[:id])
    redirect_to root_url if @micropost.nil?
  end

end
