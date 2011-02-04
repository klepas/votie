Feature: User login
  In order to interact with the website
  As a user of the website
  I want to be able to login

  Background:
    Given a user exists with login: "votie", password: "secret"

  Scenario: successful login
    Given I am on the home page
    When I follow "Sign in"
    Then I should be on the login page
    When  I fill in "user_session_login" with "votie"
    And   I fill in "user_session_password" with "secret"
    And   I press "log in"
    Then  the user should be logged in

  Scenario: trying to login when already logged in
    Given I successfully login
    When  I go to the login page
    Then  I should be on the home page
    And   I should see "You must be logged out to access this page"

