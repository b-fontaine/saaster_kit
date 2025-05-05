Feature: User Management
  As an administrator
  I want to manage users in the system
  So that I can control access to the application

  Background:
    Given the system is running
    And I am authenticated as an administrator

  Scenario: Create a new user
    When I create a user with the following details:
      | Email           | FirstName | LastName | Role  |
      | test@example.com | John      | Doe      | user  |
    Then the user should be saved in the database
    And I should receive a successful response with status code 201
    And the response should contain the user details

  Scenario: Retrieve a user by ID
    Given there is a user with email "existing@example.com"
    When I request the user by their ID
    Then I should receive a successful response with status code 200
    And the response should contain the user details

  Scenario: Update a user
    Given there is a user with email "update@example.com"
    When I update the user with the following details:
      | FirstName | LastName | Role  |
      | Jane      | Smith    | admin |
    Then the user should be updated in the database
    And I should receive a successful response with status code 200
    And the response should contain the updated user details

  Scenario: Delete a user
    Given there is a user with email "delete@example.com"
    When I delete the user
    Then the user should be removed from the database
    And I should receive a successful response with status code 204

  Scenario: List all users
    Given there are multiple users in the system
    When I request all users
    Then I should receive a successful response with status code 200
    And the response should contain a list of users
