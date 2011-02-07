class Conference < ActiveRecord::Base
  has_many :talks

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :name, :subdomain
end
