Feature: user signup
  In order to login and start using the site
  As a user
  I want to be able to sign up

  Scenario: successful sign up
    Given I am on the signup page
    And user "shoaib" does not exist
    When I fill in "user_login" with "shoaib"
    And I fill in "user_email" with "shoaib@nomad-labs.com"
    And I fill in "user_password" with "secret"
    And I fill in "user_password_confirmation" with "secret"
    And I press "sign up!"
    Then user "shoaib" should exist
    And I should see "You've successfully signed up!" within "div#flash_notice"

  @wip
  Scenario: activation email
    Given I have signed up
    When I click on my activation link
    Then I should be logged in
    And I should see account activated

  Scenario: Redirecting the user back to the evaluation after sign up
    Given I am on the current venue page
    When I follow "Review this venue"
    Then I should be on the login page
    When I fill in "user_login" with "shoaib"
    And I fill in "user_email" with "shoaib@nomad-labs.com"
    And I fill in "user_password" with "secret"
    And I fill in "user_password_confirmation" with "secret"
    And I press "sign up!"
    Then user "shoaib" should exist
    And I should see "You've successfully signed up!" within "div#flash_notice"
    And I should be on the current venue's edit evaluation page

