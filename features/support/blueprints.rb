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


Talk.blueprint do
  title { "My Talk" }
  description { "This is my talk. There are many others like it, but this one is mine." }
  link { "http://example.com" }
  creator { User.find_by_login("votie") }
  presenter { User.find_by_login("votie") }
  conference { Conference.find_by_subdomain("myconf") }
end
