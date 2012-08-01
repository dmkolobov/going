class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  def login(user)
    reset_session
  	session[:user_id] = user.id
    cookies[:email] = user.email
  end

  def logout 
  	session[:user_id] = nil
    reset_session
  end

  private

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  #Authorization exception logic here
  rescue_from CanCan::AccessDenied do |exception|
    if session[:user_id] == nil
      redirect_to login, :alert => exception.message
    else 
      redirect_to root_url, :alert => exception.message
    end
  end
end
