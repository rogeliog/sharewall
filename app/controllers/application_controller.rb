class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def requires_user
    render nothing: true unless current_user.present?
  end

  helper_method :current_user
end
