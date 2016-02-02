class UsersController < ApplicationController

  def new

  end

  def create
    @user = User.new(userparams)

    if @user.save
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end



  def userparams
    params.require(:user).permit(:username, :password)
  end

  def show
  end



end
