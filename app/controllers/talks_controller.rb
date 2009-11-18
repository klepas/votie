class TalksController < ApplicationController
  def index
    @talks = Talk.all_ordered_by_votes
  end


  def vote
    @talks = Talk.all
  end


  
end
