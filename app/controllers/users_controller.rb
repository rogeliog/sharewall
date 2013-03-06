class UsersController < ApplicationController
  respond_to :json
  before_filter :empty_preferences_if_none_arrive, only: :update

  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with @user
  end

  private

  def empty_preferences_if_none_arrive
    params[:user][:preferences] ||= {}
  end
  
end
