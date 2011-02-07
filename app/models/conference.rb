class Conference < ActiveRecord::Base
  has_many :talks

  validates_presence_of :name, :subdomain
  validates_uniqueness_of :name, :subdomain

  # TODO: Default scope order by created_at
  #       When conferences have a date, order by duration from current time, ascending
end
