Feature: user log out
  In order to maintain security
  As a user
  I want to be able to logout

  Scenario: successful logout
    Given a user exists
    And I successfully login
    When I follow "Sign out?"
    Then I should see "Logout successful!"
