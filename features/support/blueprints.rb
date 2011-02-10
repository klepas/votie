require 'machinist/active_record'
require 'sham'
#require 'faker'

User.blueprint do
  twitter_name { "votie" }
  name { "Votie App" }
  login { "votie" }
  password { "secret" }
  password_confirmation { object.password }
end


Conference.blueprint do
  name { "My Conference" }
  subdomain { "myconf" }
end
