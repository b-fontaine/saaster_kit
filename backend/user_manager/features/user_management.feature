Feature: User Management
  As a system administrator
  I want to manage users in the system
  So that I can control access to the application

  Background:
    Given the system is running
    And the database is clean

  Scenario: Create a new user
    When I create a user with the following details:
      | email           | first_name | last_name | role    |
      | john@example.com | John       | Doe       | admin   |
    Then the user should be created successfully
    And the user should have the following details:
      | email           | first_name | last_name | role    | active |
      | john@example.com | John       | Doe       | admin   | true   |

  Scenario: Get user by ID
    Given a user exists with the following details:
      | email           | first_name | last_name | role    |
      | jane@example.com | Jane       | Smith     | user    |
    When I get the user by ID
    Then I should receive the user details
    And the user should have the following details:
      | email           | first_name | last_name | role    | active |
      | jane@example.com | Jane       | Smith     | user    | true   |

  Scenario: Update user
    Given a user exists with the following details:
      | email           | first_name | last_name | role    |
      | bob@example.com  | Bob        | Johnson   | user    |
    When I update the user with the following details:
      | email           | first_name | last_name | role    |
      | bob@example.com  | Robert     | Johnson   | admin   |
    Then the user should be updated successfully
    And the user should have the following details:
      | email           | first_name | last_name | role    | active |
      | bob@example.com  | Robert     | Johnson   | admin   | true   |

  Scenario: Delete user
    Given a user exists with the following details:
      | email           | first_name | last_name | role    |
      | alice@example.com | Alice      | Brown     | user    |
    When I delete the user
    Then the user should be deleted successfully
    And the user should not exist in the system

  Scenario: List users
    Given the following users exist:
      | email           | first_name | last_name | role    |
      | user1@example.com | User       | One       | admin   |
      | user2@example.com | User       | Two       | user    |
      | user3@example.com | User       | Three     | user    |
    When I list all users
    Then I should receive a list of 3 users
    And the list should include the following users:
      | email           | first_name | last_name | role    |
      | user1@example.com | User       | One       | admin   |
      | user2@example.com | User       | Two       | user    |
      | user3@example.com | User       | Three     | user    |
