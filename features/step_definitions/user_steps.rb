Given /^I successfully login( as "([^"]+)"|)$/ do |tmp, login|
  login ||= "votie"
  password = User.make.password

  Given 'I am on the login page'
  When  'I fill in "user_session_login" with "'+login+'"'
  And   'I fill in "user_session_password" with "'+password+'"'
  And   'I press "log in"'
  Then  'I should see "Login successful!" within "p#flash"'
end
