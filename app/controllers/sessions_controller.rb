class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email( params[:user][:email] )
  	if user && user.authenticate( params[:user][:password] )
  		session[:user_id] = user.id
  		redirect_to root_url, :notice => "Logged in."
  	else
  		flash[:error] = "The email/password combination you have provided does not match any users on this site."
  		render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Logged Out."
  end
end
