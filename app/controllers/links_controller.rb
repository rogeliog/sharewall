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

  def add_click
    link = Link.find(params[:id])
    link.add_click!
    respond_with link
  end
end
