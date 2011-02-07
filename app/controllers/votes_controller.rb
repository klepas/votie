class VotesController < ApplicationController
  before_filter :require_user

  # Cast a vote
  # votes/cast/talk_id
  def cast
    talk = @conference.talks.find(params[:id])
    current_user.votes.create(:talk => talk)

    redirect_to vote_path
  end


  def remove
    talk = @conference.talks.find(params[:id])
    vote = current_user.votes.first(:conditions => {:talk_id => talk})
    vote.destroy if vote

    redirect_to vote_path
  end
end
