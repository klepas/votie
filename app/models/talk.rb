class Talk < ActiveRecord::Base
  belongs_to :presenter, :class_name => 'User', :foreign_key => 'user_id'

  validates_presence_of :title, :presenter, :description
  validates_length_of :description, :maximum => 140
end
