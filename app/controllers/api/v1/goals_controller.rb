class Api::V1::GoalsController < ApplicationController




  def show
    @goal = Goal.find(params[:id])
    @goal.age  = ((Time.current - @goal.created_at)/ 1.day).round
    render json: @goal
  end


  def create
    @goal = Goal.create!(name: params[:name], details: params[:details], user_id: params[:user_id], notification_freq: params[:notification_freq], notification_type: params[:notification_type])
    @goal.age  = ((Time.current - @goal.created_at)/ 1.day).round
    render json: @goal
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update(name: params[:name], details: params[:details], notification_freq: params[:notification_freq], notification_type: params[:notification_type])
    @goal.age  = ((Time.current - @goal.created_at)/ 1.day).round
    render json: @goal
  end

  def goals_status
    @goal = Goal.find(params[:id])
    @goal.update(completed: params[:completed])
    render json: @goal
  end

  def destroy
    Goal.find(params[:id]).delete
  end




end
