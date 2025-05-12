# Client Manager Tests

This directory contains tests for the client manager service.

## Prerequisites

To run these tests, you need:

1. Docker installed and running on your machine
2. Go 1.22 or later

The tests use Testcontainers to automatically spin up PostgreSQL for testing, so you don't need to manually set up these services. Temporal workflows are mocked for testing purposes.

## Running the Tests

To run the tests:

```bash
go test -v
```

The tests will automatically:
1. Start a PostgreSQL container
2. Create the necessary database schema
3. Run the API tests against the container
4. Run the Temporal workflow tests with mocks
5. Clean up the containers when done

If you want to skip the tests (e.g., if Docker is not available):

```bash
SKIP_DB_TESTS=true go test -v
```

## Test Structure

The tests are organized as follows:

- `client_test.go`: Main test file that runs the Cucumber/Godog tests
- `steps/`: Directory containing step definitions for the Cucumber/Godog tests
  - `client_steps.go`: Step definitions for client management API tests
  - `temporal_steps.go`: Step definitions for Temporal workflow tests
- `features/`: Directory containing Cucumber/Godog feature files
  - `client_management.feature`: Feature file for client management API tests
  - `temporal_workflows.feature`: Feature file for Temporal workflow tests

## Test Environment

The tests use Testcontainers to automatically create and manage the test environment. However, you can still configure the environment using the following environment variables:

- `SKIP_DB_TESTS`: Set to "true" to skip tests that require Docker and test containers

## How It Works

The tests use the following technologies:

1. **Testcontainers**: A library that allows you to create and manage Docker containers for testing
2. **PostgreSQL**: A container running PostgreSQL for database tests
3. **Mocks**: Mock implementations of the Temporal client for workflow tests
4. **Godog**: A Go implementation of Cucumber for BDD-style tests

## Troubleshooting

If you encounter issues with the tests:

1. Make sure Docker is running on your machine
2. Check that you have sufficient permissions to create Docker containers
3. Ensure you have enough disk space and memory for the containers
4. If tests hang, try increasing the timeout values in the test code
5. If you see port conflicts, the tests might be trying to use ports that are already in use
6. If you see database schema errors, check that the schema in the test container matches the schema expected by the repository
