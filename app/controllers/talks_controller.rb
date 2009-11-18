class TalksController < ApplicationController
  def index
    @talks = Talk.all_ordered_by_votes
  end
end
