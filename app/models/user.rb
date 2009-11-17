class User < ActiveRecord::Base
  has_many :talks, :foreign_key => 'user_id'
  has_many :votes

  validates_presence_of :twitter_name


  def voted_for?(talk)
    self.votes.exists?(:talk_id => talk.id)
  end


  def vote!(talk)
    self.votes.create(:talk => talk)
  end
end
