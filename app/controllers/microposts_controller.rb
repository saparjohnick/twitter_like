class MicropostsController < ApplicationController
  before_action :user_signed_in?, only: %i[create destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = DelayedMicropostForm.new(micropost_params)
    if @micropost.submit
      flash[:success] = 'Micropost created.'
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    raise ActiveRecord::RecordNotFound unless @micropost

    authorize @micropost
    @micropost.destroy!
    flash[:success] = 'Micropost deleted.'
    redirect_to root_url
  end

  private

  def micropost_params
    result = params.require(:micropost).permit(:content, :picture, :user, :is_delayed)
    result.merge('user' => current_user)
  end

  def correct_user
    @micropost = current_user.microposts.find(params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
