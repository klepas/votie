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


  def edit
    @talk = Talk.find(params[:id])

    if @talk.presenter != @user
      flash[:notice] = "You may not edit someone else's talk."
      redirect_to talks_path and return
    end
  end


  def update
    @talk = Talk.find(params[:id])
    
    if @talk.presenter != @user
      flash[:notice] = "You may not edit someone else's talk."
      redirect_to talks_path and return
    end

    if @talk.update_attributes(params[:talk])
      flash[:notice] = "Your talk has been updated."
      redirect_to talks_path
    else
      render :action => "edit"
    end
  end
end
