class TalksController < ApplicationController
  before_filter :init
  before_filter :require_user, :except => :index

  def init
    # Default to not showing vote links on views
    @allow_voting = false
  end


  def index
    @talks = Talk.all_ordered_by_votes
  end


  def vote
    @talks = Talk.all(:order => 'id DESC')
    @allow_voting = true
  end


  def presenters
    @presenters = User.all_presenters
  end


  def new
    @talk = Talk.new
  end

  def create
    @talk = Talk.new(params[:talk])
    @talk.presenter = current_user

    if @talk.save
      flash[:notice] = 'Your exceedingly awesome talk was added to the list. Good luck!'
      redirect_to talks_path
    else
      render :action => "new"
    end
  end


  def edit
    @talk = Talk.find(params[:id])

    if @talk.presenter != current_user
      flash[:notice] = "You may not edit someone else's talk."
      redirect_to talks_path
    end
  end


  def update
    @talk = Talk.find(params[:id])

    if @talk.presenter != current_user
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


  def destroy
    @talk = Talk.find(params[:id])

    if @talk.presenter != current_user
      flash[:notice] = "You may not delete someone else's talk."
      redirect_to talks_path and return
    end

    @talk.destroy
    redirect_to talks_path
  end
end
