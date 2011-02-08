class TalksController < ApplicationController
  before_filter :init
  before_filter :require_user, :except => :index

  def init
    # Default to not showing vote links on views
    @allow_voting = false
  end


  def index
    @talks = @conference.talks.ordered_by_votes
  end


  def vote
    @talks = @conference.talks.all(:order => 'id DESC')
    @allow_voting = true
  end


  def presenters
    # Get all presenters, ordered by when their most recent talk was submitted
    @presenters = @conference.presenters.order('talks.id DESC')
  end


  def new
    @talk = @conference.talks.new
  end

  def create
    @talk = @conference.talks.new(params[:talk])
    @talk.presenter = current_user

    if @talk.save
      flash[:notice] = 'Your exceedingly awesome talk was added to the list. Good luck!'
      redirect_to talks_path
    else
      render :action => "new"
    end
  end


  def edit
    @talk = @conference.talks.find(params[:id])

    if @talk.presenter != current_user
      flash[:notice] = "You may not edit someone else's talk."
      redirect_to talks_path
    end
  end


  def update
    @talk = @conference.talks.find(params[:id])

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
    @talk = @conference.talks.find(params[:id])

    if @talk.presenter != current_user
      flash[:notice] = "You may not delete someone else's talk."
      redirect_to talks_path and return
    end

    @talk.destroy
    redirect_to talks_path
  end
end
