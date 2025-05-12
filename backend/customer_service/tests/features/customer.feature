Feature: Customer Management
  As a user of the customer service
  I want to manage customer information
  So that I can keep track of my customers

  Scenario: Add a new customer
    Given I have a valid customer UUID
    When I add a customer with the following details:
      | uuid                                 | firstName | lastName | contactEmail        | contactPhone  |
      | 550e8400-e29b-41d4-a716-446655440000 | John      | Doe      | john.doe@example.com | +1234567890 |
    Then the customer should be saved successfully

  Scenario: Get an existing customer
    Given I have a customer with UUID "550e8400-e29b-41d4-a716-446655440000" in the system
    When I request the customer with UUID "550e8400-e29b-41d4-a716-446655440000"
    Then I should receive the customer details:
      | uuid                                 | firstName | lastName | contactEmail        | contactPhone  |
      | 550e8400-e29b-41d4-a716-446655440000 | John      | Doe      | john.doe@example.com | +1234567890 |

  Scenario: Update an existing customer
    Given I have a customer with UUID "550e8400-e29b-41d4-a716-446655440000" in the system
    When I update the customer with the following details:
      | uuid                                 | firstName | lastName | contactEmail           | contactPhone  |
      | 550e8400-e29b-41d4-a716-446655440000 | Jane      | Smith    | jane.smith@example.com | +9876543210 |
    Then the customer should be updated successfully
    And when I request the customer with UUID "550e8400-e29b-41d4-a716-446655440000"
    Then I should receive the customer details:
      | uuid                                 | firstName | lastName | contactEmail           | contactPhone  |
      | 550e8400-e29b-41d4-a716-446655440000 | Jane      | Smith    | jane.smith@example.com | +9876543210 |

  Scenario: List all customers
    Given I have the following customers in the system:
      | uuid                                 | firstName | lastName | contactEmail           | contactPhone  |
      | 550e8400-e29b-41d4-a716-446655440000 | Jane      | Smith    | jane.smith@example.com | +9876543210 |
      | 550e8400-e29b-41d4-a716-446655440001 | Bob       | Johnson  | bob.johnson@example.com | +1122334455 |
    When I request a list of all customers
    Then I should receive a list containing 2 customers
