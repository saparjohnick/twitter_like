class Api::V1::MicropostsSearchController < ApplicationController
  before_action :authenticate_user!

  def index
    posts = QueryObjects::SearchMicropostQuery.call(params[:query])
    render json: posts
  end
end
