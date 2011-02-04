Feature: user profile
  In order to update my details
  As a user
  I want to be able to edit my profile

  Scenario: successful update
    Given a user exists
    And I successfully login
    When I go to the homepage
    And I follow "Update my details"
    Then I should be on the edit user page
    When I fill in "user_login" with "votie_mod"
    And I fill in "user_twitter_name" with "votie_app_mod"
    And I fill in "user_name" with "Votie App Mod"
    And I fill in "user_password" with "changed"
    And I fill in "user_password_confirmation" with "changed"
    And I press "update my details"
    Then user "votie" should not exist
    And user "votie_mod" should exist with login: "votie_mod", twitter_name: "votie_app_mod", name: "Votie App Mod"
    And I should see "You've succesfully updated your details." within "div#flash_notice"
