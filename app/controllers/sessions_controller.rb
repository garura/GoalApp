class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_credentials(userparams[:username], userparams[:password])
    if user
      login!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = "Invalid Username/Password combination"
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end


  def userparams
    params.require(:user).permit(:username, :password)
  end



end
