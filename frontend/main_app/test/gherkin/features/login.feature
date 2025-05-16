Feature: Login
  Whether you are a user or an admin, you can login to the system.

  Scenario: Login page by default
    Given My app is running
    Then I should see a {ElevatedButton} with text {"Login"}

  Scenario: Logged user can see his profile
    Given My app is running
    When I connect as {'john'}
    Then I sould see text {"Welcome, John Doe"}
