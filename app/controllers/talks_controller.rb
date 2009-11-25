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
end
