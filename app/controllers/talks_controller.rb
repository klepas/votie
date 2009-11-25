class TalksController < ApplicationController
  def secure?
    not ['index'].include?(action_name)
  end


  def index
    @talks = Talk.all_ordered_by_votes
  end


  def vote
    @talks = Talk.all(:order => 'id DESC')
  end


  def presenters
    @presenters = User.all_presenters
  end


  def new
    @talk = Talk.new
  end

  def create
    @talk = Talk.new(params[:talk])
    @talk.presenter = @user

    if @talk.save
      flash[:notice] = 'Your exceedingly awesome talk was added to the list. Good luck!'
      redirect_to talks_path
    else
      render :action => "new"
    end
  end
end
