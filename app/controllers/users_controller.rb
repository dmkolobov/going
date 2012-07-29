class UsersController < ApplicationController
	def new  
		@user = User.new
	end

	def show
		@user = User.find( params[:id] )
	end

	def edit
		@user = User.find( params[:id] )
	end

	def create
		@user = User.new( params[:user] )

		if @user.save
			login @user
			redirect_to root_url
		else
			flash[:error] = @user.errors.empty? ? "An error has occured, please try again" : @user.errors.full_messages.to_sentence 
			render :new
		end
	end

	def update
		@user = User.find( params[:id] )

		if @user.update_attributes( params[:user] )
			redirect_to @user
		else
			flash[:error] = @user.errors.empty? ? "An error has occured, please try again" : @user.errors.full_messages.to_sentence 
			render :edit
		end
	end

	def destroy
	end
end
