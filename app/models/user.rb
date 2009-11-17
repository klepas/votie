class User < ActiveRecord::Base
  has_many :talks, :foreign_key => 'user_id'

  validates_presence_of :twitter_name
end
