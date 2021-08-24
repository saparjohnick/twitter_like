class Api::V1::MicropostsSearchController < ApplicationController

  def index
    posts = QueryObjects::SearchMicropostQuery.new.call(params[:query])
    render json: posts
  end
end
