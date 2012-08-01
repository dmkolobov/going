class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by_email( params[:email] )
  	if @user && @user.authenticate( params[:password] )
  		login( @user )
      redirect_to root_url
  	else
  		flash[:error] = "The email/password combination you have provided does not match any users on this site."
  		render :new
  	end
  end

  def destroy
  	logout
    redirect_to root_url
  end
end
