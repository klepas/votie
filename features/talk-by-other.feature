Feature: Submitting talks not presented by yourself
  In order to ensure that all presentations are loaded into the system
  As a conference organiser
  I want to be able to submit talks that were presented by other people

  Background:

  Scenario: submitting a talk presented by the submitter

  Scenario: submitting a talk presented by an existing user

  Scenario: submitting a talk presented by an non-existent user
    Given a user exists
    And a conference exists
    And I successfully login
    And I visit the subdomain "myconf"
    And I am on the new talk page
    When I fill in "talk_title" with "My Spiffy Talk"
    And I fill in "talk_description" with "This talk is awesome!"
    And I fill in "talk_link" with "http://google.com"
    And I choose "Someone else"
    And I fill in "talk_presenter_attributes_name" with "Pascal Klein"
    And I fill in "talk_presenter_attributes_twitter_name" with "klepas"
    And I press "submit"
    Then I should see "Your exceedingly awesome talk was added to the list. Good luck!"
    When I go to the talks page
    Then I should see "My Spiffy Talk" within ".talk .title"
    And I should see "Pascal Klein" within ".talk .presenter"
    And a user should exist with login: "klepas", name: "Pascal Klein"


  Scenario: editing a talk created and presented by the same person
  
  Scenario: the talk creator edits a talk presented by someone else

  Scenario: the talk presentor edits a talk created by someone else

