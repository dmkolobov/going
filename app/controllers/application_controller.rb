class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    #CanCan exception logic here
  end

  def login(user)
  	session[:user_id] = user.id
  end

  def logout 
  	session[:user_id] = nil
  end

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
