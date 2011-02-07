class ConferencesController < ApplicationController
  def index
    @conferences = Conference.all
  end

  def new
    @conference = Conference.new
  end
end
