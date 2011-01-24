class User < ActiveRecord::Base
  has_many :talks, :foreign_key => 'user_id'
  has_many :votes

  validates_presence_of :twitter_name


  # Get all users who presented a talk, ordered
  # by when their most recenttalk was submitted
  def self.all_presenters
    joins(:talks).order('talks.id DESC').group('user_id')
  end


  def voted_for?(talk)
    self.votes.exists?(:talk_id => talk.id)
  end


  def can_vote_for?(talk)
    !self.voted_for?(talk) and self.num_votes_remaining > 0
  end


  def vote!(talk)
    self.votes.create(:talk => talk)
  end


  def num_votes_remaining
    Site::NUM_VOTES_PER_USER - self.votes.count
  end
end
