class ConferencesController < ApplicationController
  before_filter :require_user, :except => :index

  def index
    @conferences = Conference.all
  end

  def new
    @conference = Conference.new
  end

  def create
    @conference = Conference.new(params[:conference])

    if @conference.save
      flash[:notice] = "Your conference \"#{@conference.name}\" has been created!"
      redirect_to conference_path(@conference)
    else
      render :action => "new"
    end
  end

  def show
    @conference = Conference.find(params[:id])
    redirect_to conference_talks_path(@conference)
  end
end
