class TeamsController < ApplicationController

  def index
    @teams = Team.all

  end

  def show
    @team = Team.find(params[:id])
    @members = User.where("team_id = ?", @team.id)
    @nonmembers = User.where("team_id IS NULL")
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to @team }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @team = Team.find(params[:id])
  #Remove all team members prior to delete
    @members = User.where("team_id = ?", @team.id)
    @members.each do |member|
      member.team_id = nil
      member.save
    end
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_path }
    end
  end

end
