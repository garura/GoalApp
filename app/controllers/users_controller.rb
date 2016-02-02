class UsersController < ApplicationController

  before_action :require_login!, only: :show

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
    @user = User.find(params[:id])
    goals = @user.goals
    @public_goals = goals.select { |goal| goal.visible == true }
    @hidden_goals = goals.select { |goal| goal.visible == false && goal.user_id == current_user.id }
  end



end
