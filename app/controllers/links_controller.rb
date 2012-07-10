class LinksController < ApplicationController
  respond_to :json

  def index
    respond_with Link.all
  end

  def show
    respond_with Link.find(params[:id])
  end

  def create
    respond_with Link.create(params[:link])
  end

  def update
    respond_with Link.update(params[:id], params[:link])
  end

  def destroy
    respond_with Link.destroy(params[:id])
  end
end
