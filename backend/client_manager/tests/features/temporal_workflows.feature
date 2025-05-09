Feature: Temporal Workflows
  As a developer
  I want to use Temporal workflows for client operations
  So that I can ensure reliability and fault tolerance

  Scenario: Execute AddClient workflow
    Given I have a Temporal client connected to "client-namespace"
    When I execute the AddClient workflow with the following details:
      | uuid                                 | firstName | lastName | contactEmail       | phoneNumber  |
      | 550e8400-e29b-41d4-a716-446655440000 | John      | Doe      | john.doe@email.com | +1234567890  |
    Then the workflow should complete successfully
    And the client should be saved in the database

  Scenario: Execute GetClient workflow
    Given I have a Temporal client connected to "client-namespace"
    And a client exists with UUID "550e8400-e29b-41d4-a716-446655440000"
    When I execute the GetClient workflow with UUID "550e8400-e29b-41d4-a716-446655440000"
    Then the workflow should complete successfully
    And I should receive the client details

  Scenario: Execute GetClient workflow for non-existent client
    Given I have a Temporal client connected to "client-namespace"
    And no client exists with UUID "550e8400-e29b-41d4-a716-446655440000"
    When I execute the GetClient workflow with UUID "550e8400-e29b-41d4-a716-446655440000"
    Then the workflow should complete successfully
    And I should receive an empty client
