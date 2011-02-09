Feature: Multiple conferences
  In order to provide votie for many conferences
  As a conference organiser
  I want to have multiple conferences

  Background:
    Given a user exists with login: "votie", password: "secret"

  Scenario: creating a conference
    Given I successfully login
    And   I am on the home page
    When  I follow "set up a new conference"
    Then  I should be on the new conference page
    When  I fill in "conference_name" with "My Conference"
    And   I fill in "conference_subdomain" with "my-conference"
    And   I press "create"
    Then  I should see "Your conference 'My Conference' has been created!" within "p#flash"
    And   I should be on the talks page


  Scenario: user must be logged in to create a conference
    Given I am on the home page
    Then I should not see "Set up a new conference"
    When I go to the new conference page
    Then I should be on the home page
    And I should see "Please log in to view this page."

  Scenario: num votes remaining is not shown on conferences list page
    Given I am on the home page
    Then I should not see "votes remaining"
