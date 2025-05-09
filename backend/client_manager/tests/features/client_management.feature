Feature: Client Management
  As a user of the system
  I want to manage my client information
  So that I can keep my profile up to date
  And I want to use Temporal workflows for reliability

  Scenario: Add a new client
    Given I am authenticated with UUID "550e8400-e29b-41d4-a716-446655440000"
    When I add a client with the following details:
      | firstName    | lastName | contactEmail       | phoneNumber  |
      | John         | Doe      | john.doe@email.com | +1234567890  |
    Then the client should be saved successfully
    And I should receive the client details in the response

  Scenario: Get client information
    Given I am authenticated with UUID "550e8400-e29b-41d4-a716-446655440000"
    And I have a client record in the system
    When I request my client information
    Then I should receive my client details

  Scenario: Get client information when no record exists
    Given I am authenticated with UUID "550e8400-e29b-41d4-a716-446655440000"
    And I do not have a client record in the system
    When I request my client information
    Then I should receive an empty client with my UUID
