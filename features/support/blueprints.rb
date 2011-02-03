require 'machinist/active_record'
require 'sham'
#require 'faker'

User.blueprint do
  twitter_name { "someone" }
  name { "Some User" }
  login { "someone" }
  password { "password" }
  password_confirmation { object.password }
end
