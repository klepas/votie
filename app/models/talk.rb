class Talk < ActiveRecord::Base
  belongs_to :conference
  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :presenter, :class_name => 'User', :foreign_key => 'user_id'
  has_many :votes, :dependent => :destroy

  accepts_nested_attributes_for :presenter
  
  validates_presence_of :title, :creator, :presenter, :description
  validates_length_of :description, :maximum => 140

  scope :ordered_by_votes, joins('LEFT OUTER JOIN votes ON (votes.talk_id=talks.id)').group('talks.id').order('COUNT(votes.id) DESC, talks.id DESC')

  after_initialize :set_default_values
  before_validation :set_presenter
  before_save :ensure_link_is_absolute

  def set_default_values
    self.link ||= "http://"
  end

  def ensure_link_is_absolute
    unless self.link.blank? or self.link =~ /^http:\/\//
      self.link = "http://"+self.link
    end

    if self.link == "http://"
      self.link = ""
    end
  end

  def set_presenter
    # Set the presenter
    self.presenter = self.creator if self.creator_is_presenter

    # Detect a reference to an existing presenter
    presenter = User.where("name = ? OR twitter_name = ?", self.presenter.name, self.presenter.twitter_name).first
    self.presenter = presenter if presenter

    # If we're creating a new presenter, initialise the user name and password
    if self.presenter.new_record?
      self.presenter.login = self.presenter.twitter_name
      self.presenter.login = self.presenter.name.gsub(/ /, '-') if self.presenter.login.blank?

      password = Authlogic::Random.friendly_token
      self.presenter.password = password
      self.presenter.password_confirmation = password
    end
    
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


  def creator_is_presenter
    @creator_is_presenter
  end
  def creator_is_presenter=(val)
    @creator_is_presenter = (val == '1')
  end
end
