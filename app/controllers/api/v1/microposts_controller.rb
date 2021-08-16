class Api::V1::MicropostsController < ApplicationController
  before_action :authenticate_user

  def index
    user = User.friendly.find(params[:id])
    posts = user.microposts
    render json: posts
  end
end
