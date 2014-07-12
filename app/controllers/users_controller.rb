class UsersController < ApplicationController
  before_filter :only_myself, only: [:edit, :update]

  def index
    @users = User.without_user(current_user)
  end

  def status
    @user = User.find(params[:id])
    respond_to do |format|
      format.json { render :json =>  @user.to_json(:only => [:id, :status], :methods => [:full_name]) }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @teams = Team.all
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(params[:user])
    redirect_to users_path
  end

  def leave_team
    user = User.find(params[:id])
    user.team_id = nil
    user.save
    redirect_to(:back)
  end

  def join_team
    user = User.find(params[:id]) 
    teamid = Rails.application.routes.recognize_path(request.referer)
    user.team_id = teamid[:id]
    user.save
    redirect_to(:back)
  end

  private

  def only_myself
    unless current_user.id == params[:id].to_i
      flash[:alert] = "You can't edit other users' information."
      redirect_to users_path
    end
  end

end
