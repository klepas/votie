class User < ActiveRecord::Base
  has_many :talks, :foreign_key => 'user_id'
  has_many :votes

  validates_presence_of :twitter_name


  # Get all users who presented a talk, ordered alphabetically
  def self.all_presenters
    presenters = all(:joins => :talks, :group => 'user_id', :order => 'twitter_name')
    presenters = presenters.sort_by { |p| -p.talks.last.id }
    presenters
  end


  def voted_for?(talk)
    self.votes.exists?(:talk_id => talk.id)
  end


  def vote!(talk)
    self.votes.create(:talk => talk)
  end
end
