class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :talk

  validates_presence_of :user, :talk


  # Users can vote a limited number of times
  validates_each :user, :if => :user do |record, attr, value|
    if record.user.votes.count >= Site::NUM_VOTES_PER_USER
      record.errors.add attr, "You have already used all of your votes."
    end
  end

  # Users can vote on each talk only once
  validates_each :user, :if => Proc.new {|vote| vote.user and vote.talk} do |record, attr, value|
    record.errors.add attr, "You have already voted for that talk." if record.user.voted_for? record.talk
  end
end
