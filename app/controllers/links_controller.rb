class LinksController < ApplicationController
  respond_to :json
  before_filter :requires_user, only: [:create]

  def index
    respond_with Link.all
  end

  def show
    respond_with Link.find(params[:id])
  end

  def create
    respond_with Link.create(params[:link].merge(user_id: current_user.id))
  end

  def update
    @link = Link.find(params[:id])
    @link.update_attributes(params[:link])
    respond_with @link
  end

  def add_click
    link = Link.find(params[:id])
    link.add_click!
    Innsights.report('Link Clicked', user: current_user).run
    respond_with link
  end
end
