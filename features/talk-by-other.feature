Feature: Submitting talks not presented by yourself
  In order to ensure that all presentations are loaded into the system
  As a conference organiser
  I want to be able to submit talks that were presented by other people

  Background:
    Given a user exists
    And another user exists with login: "presenter", name: "Andrew Presenter", twitter_name: "presenter"
    And a conference exists
    And I successfully login
    And I visit the subdomain "myconf"

  Scenario: submitting a talk presented by the submitter
    Given I am on the new talk page
    When I fill in the talk details
    And I specify that the talk is presented by myself
    And I press "submit"
    Then the talk submission should have been successful, with presenter: "Votie App"
    And 2 users should exist

  Scenario: submitting a talk presented by an existing user
    Given I am on the new talk page
    When I fill in the talk details
    And I specify that the talk is presented by "Andrew Presenter" with twitter name "presenter"
    And I press "submit"
    Then the talk submission should have been successful, with presenter: "Andrew Presenter"
    And 2 users should exist

  Scenario: submitting a talk presented by an non-existent user
    Given I am on the new talk page
    When I fill in the talk details
    And I specify that the talk is presented by "Pascal Klein" with twitter name "klepas"
    And I press "submit"
    Then the talk submission should have been successful, with presenter: "Pascal Klein"
    And 3 users should exist
    And a user should exist with login: "klepas", name: "Pascal Klein"


  Scenario: editing a talk created and presented by the same person
  
  Scenario: the talk creator edits a talk presented by someone else

  Scenario: the talk presentor edits a talk created by someone else

