class Talk < ActiveRecord::Base
  belongs_to :presenter, :class_name => 'User', :foreign_key => 'user_id'
  has_many :votes

  validates_presence_of :title, :presenter, :description
  validates_length_of :description, :maximum => 140


  def self.all_ordered_by_votes
    talks = Talk.all
    talks = talks.sort_by { |talk| [talk.votes.count, talk.id] }
    talks.reverse!
    talks
  end
end
