class Api::V1::MicropostsController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.friendly.find(current_user.id)
    posts = user.microposts
    render json: posts
  end
end
