class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.friendly.find(params[:id])
  end



end
