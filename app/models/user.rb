class User < ActiveRecord::Base
  acts_as_authentic

  has_many :talks, :foreign_key => 'user_id', :dependent => :destroy
  has_many :votes, :dependent => :destroy


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


  def has_twitter?
    !self.twitter_name.blank?
  end
end
