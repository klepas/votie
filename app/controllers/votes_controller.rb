class VotesController < ApplicationController
  # Cast a vote
  # votes/cast/talk_id
  def cast
    talk = Talk.find(params[:id])
    @user.votes.create(:talk => talk)

    redirect_to vote_path
  end


  def remove
    talk = Talk.find(params[:id])
    vote = @user.votes.first(:conditions => {:talk_id => talk})
    vote.destroy if vote

    redirect_to vote_path
  end

end
