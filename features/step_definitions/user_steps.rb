Given /^I successfully login$/ do
  Given 'I am on the login page'
  When  'I fill in "user_session_login" with "votie"'
  And   'I fill in "user_session_password" with "secret"'
  And   'I press "log in"'
  Then  'the user should be logged in'  
end
