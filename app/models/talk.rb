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


  def num_votes
    self.votes.count
  end


  # Guesses whether slides are PDF (.pdf extension), a slideshare link (contains slideshare.com)
  # or other. Returns type 'pdf', 'slideshare' or 'other'.
  def slide_type
    case self.link
    when /\.pdf$/
      'pdf'
    when /slideshare\.com/
      'slideshare'
    else
      'other'
    end
  end
end
