class ConferencesController < ApplicationController
  before_filter :require_user, :except => :index
  # TODO: Disable before_filter :load_conference from application_controller?

  def index
    @conferences = Conference.all
  end

  def new
    @conference = Conference.new
  end

  def create
    @conference = Conference.new(params[:conference])

    if @conference.save
      flash[:notice] = "Your conference '#{@conference.name}' has been created!"
      redirect_to talks_url(:subdomain => @conference.subdomain)
    else
      render :action => "new"
    end
  end
end
