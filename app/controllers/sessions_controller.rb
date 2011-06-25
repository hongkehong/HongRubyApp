class SessionsController < ApplicationController

  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    # use User class method! return user this instance from obj_db mapping
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in Again"
      render 'new'
    else
      sign_in user 
      #redirect_to  user #current_user
      redirect_back_or user
    end
  end

  def destroy
      session[:cur]=nil
		redirect_to home_url
  end
end

