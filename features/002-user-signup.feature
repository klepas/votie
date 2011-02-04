Feature: user signup
  In order to login and start using the site
  As a user
  I want to be able to sign up

  Scenario: successful sign up
    Given user "votie" does not exist
    And I am on the home page
    When I follow "Register"
    Then I should be on the signup page
    When I fill in "user_login" with "votie"
    And I fill in "user_twitter_name" with "votie_app"
    And I fill in "user_name" with "Votie App"
    And I fill in "user_password" with "secret"
    And I fill in "user_password_confirmation" with "secret"
    And I press "sign up!"
    Then user "votie" should exist with login: "votie", twitter_name: "votie_app", name: "Votie App"
    And I should see "You've successfully signed up!" within "div#flash_notice"
