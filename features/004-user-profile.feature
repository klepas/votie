Feature: user profile
  In order to update my details
  As a user
  I want to be able to edit my profile

  Scenario: successful update
    Given a user exists with login: "votie"
    And I successfully login
    When I go to the homepage
    And I follow "Update my details"
    Then I should be on the edit user page for "votie"
    When I fill in "user_login" with "votie_mod"
    And I fill in "user_twitter_name" with "votie_app_mod"
    And I fill in "user_name" with "Votie App Mod"
    And I fill in "user_password" with "changed"
    And I fill in "user_password_confirmation" with "changed"
    And I press "update my details"
    Then a user should not exist with login: "votie"
    And a user should exist with login: "votie_mod", twitter_name: "votie_app_mod", name: "Votie App Mod"
    And I should see "You've successfully updated your details." within "p#flash"


  Scenario: attempting to modify a different user
    Given a user exists with login: "alice"
    And a user exists with login: "bob"
    And I successfully login as "alice"
    When I go to the edit user page for "bob"
    Then I should be on the home page
    And I should see "You may not modify that user."
