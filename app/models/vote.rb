class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk

  validates_presence_of :user, :talk


  # Users can vote a limited number of times
  validates_each :user, :if => Proc.new {|vote| vote.user and vote.talk} do |vote, attr, value|
    if vote.user.num_votes_remaining(vote.talk.conference) == 0
      vote.errors.add attr, "You have already used all of your votes."
    end
  end

  # Users can vote on each talk only once
  validates_each :user, :if => Proc.new {|vote| vote.user and vote.talk} do |vote, attr, value|
    vote.errors.add attr, "You have already voted for that talk." if vote.user.voted_for? vote.talk
  end
end
