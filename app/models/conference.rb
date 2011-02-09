class Conference < ActiveRecord::Base
  has_many :talks
  has_many :presenters, :through => :talks, :uniq => true
  has_many :votes, :through => :talks, :uniq => true

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :name, :subdomain

  NUM_VOTES_PER_USER = 3

  # TODO: When conferences have a date, order by absolute duration from current time, ascending
  default_scope order('created_at DESC')
end
