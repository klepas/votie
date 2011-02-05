class InitUserLoginFromTwitterName < ActiveRecord::Migration
  def self.up
    User.all.each do |user|
      user.login = user.twitter_name
      password = rand(100000)
      user.password = password
      user.password_confirmation = password
      user.save!
    end
  end

  def self.down
    # Can't reverse, since authlogic won't allow blank login names
    # This is not so bad, as this field will be removed in the next prior migration
  end
end
