Feature: user log out
  In order to be secure
  As a user
  I want to be able to logout

  Scenario: successful logout
    Given a user exists with login: "shoaib", password: "secret", email: "shoaib@gmail.com"
    And I successfully login
    When I follow "logout"
    Then I should see "Logout successful!"