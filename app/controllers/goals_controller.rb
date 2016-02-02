class GoalsController < ApplicationController

  before_action :require_login!
  before_action :require_user_owns_goal!, only: [:edit, :update, :destroy]


  def require_login!
    redirect_to new_session_url unless !!current_user
  end

  def require_user_owns_goal
    redirect_to goals_url unless current_user.id == params[:id]
  end

  def new

  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:error] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to user_url(@goal.user_id)
    else
      flash.now[:error] = @goal.errors.full_messages
      render :edit
    end
  end

  def index
    goals = Goal.all
    @visible_goals = goals.select { |goal| goal.visible == true || goal.user_id == current_user.id }
    @hidden_goals = goals - @visible_goals
  end


  private

  def goal_params
    params.require(:goals).permit(:name, :visible, :completed, :user_id)
  end





end
