# User Manager Microservice

A Go-based microservice for user management with PostgreSQL database, Dapr sidecar for Keycloak token validation, and Temporal worker integration.

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Running the Service](#running-the-service)
- [API Endpoints](#api-endpoints)
- [Using Temporal Workflows](#using-temporal-workflows)
  - [Creating a User via Temporal](#creating-a-user-via-temporal)
  - [Workflow Execution](#workflow-execution)
- [Authentication](#authentication)
- [Running Tests](#running-tests)
  - [Unit Tests](#unit-tests)
  - [Integration Tests](#integration-tests)
  - [End-to-End Tests](#end-to-end-tests)
- [Configuration](#configuration)
- [Troubleshooting](#troubleshooting)

## Overview

The User Manager microservice is responsible for managing user data within the SaaS B2B platform. It provides:

- User CRUD operations via REST API
- Temporal workflows for user creation and management
- Keycloak integration for authentication and authorization
- PostgreSQL database for data persistence
- Dapr sidecar for service-to-service communication

## Architecture

The service follows a clean architecture approach:

```
user_manager/
├── cmd/                  # Application entry point
├── internal/             # Internal packages
│   ├── auth/             # Authentication with Keycloak
│   ├── config/           # Configuration management
│   ├── handlers/         # HTTP handlers
│   ├── models/           # Data models
│   ├── repository/       # Database access
│   └── temporal/         # Temporal worker
├── deployments/          # Deployment configurations
│   └── dapr/             # Dapr configuration
├── scripts/              # Utility scripts
└── tests/                # Test files
```

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Go 1.22 or later (for local development)
- Temporal server running
- PostgreSQL database
- Keycloak for authentication

### Running the Service

1. **Using Docker Compose (recommended)**

   The service is configured to run as part of the SaaS B2B platform:

   ```bash
   # From the root directory
   docker compose up -d
   ```

   This will start the user_manager service along with its PostgreSQL database and Dapr sidecar.

2. **Running Locally**

   For local development:

   ```bash
   # Set up environment variables
   export DB_HOST=localhost
   export DB_PORT=5432
   export DB_USER=user_manager
   export DB_PASSWORD=password
   export DB_NAME=user_db
   export TEMPORAL_ADDRESS=localhost:7233

   # Run the service
   cd cmd
   go run main.go
   ```

## API Endpoints

The service exposes the following REST endpoints:

- `GET /health` - Health check endpoint
- `GET /api/v1/users` - List all users
- `GET /api/v1/users/{id}` - Get a user by ID
- `POST /api/v1/users` - Create a new user
- `PUT /api/v1/users/{id}` - Update a user
- `DELETE /api/v1/users/{id}` - Delete a user

Example request to create a user:

```bash
curl -X POST http://localhost:8082/api/v1/users \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <your-token>" \
  -d '{
    "email": "user@example.com",
    "first_name": "John",
    "last_name": "Doe",
    "role": "user"
  }'
```

## Using Temporal Workflows

The service uses Temporal for orchestrating user management workflows.

### Creating a User via Temporal

You can create a user by starting the `CreateUserWorkflow` workflow:

```dart
// Dart client example
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRequest {
  final String email;
  final String firstName;
  final String lastName;
  final String role;

  UserRequest({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'role': role,
  };
}

class UserResponse {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String role;
  final bool active;

  UserResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.active,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    id: json['id'],
    email: json['email'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    role: json['role'],
    active: json['active'],
  );
}

class TemporalClient {
  final String baseUrl;
  final String namespace;
  final http.Client _httpClient = http.Client();

  TemporalClient({
    this.baseUrl = 'http://localhost:7233/api/v1',
    this.namespace = 'default',
  });

  Future<String> startWorkflow({
    required String workflowType,
    required String taskQueue,
    required String workflowId,
    required Map<String, dynamic> input,
  }) async {
    final response = await _httpClient.post(
      Uri.parse('$baseUrl/namespaces/$namespace/workflows'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'workflow_type': workflowType,
        'task_queue': taskQueue,
        'workflow_id': workflowId,
        'input': input,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to start workflow: ${response.body}');
    }

    final data = jsonDecode(response.body);
    return data['workflow_id'];
  }

  Future<Map<String, dynamic>> getWorkflowResult(String workflowId) async {
    final response = await _httpClient.get(
      Uri.parse('$baseUrl/namespaces/$namespace/workflows/$workflowId/result'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get workflow result: ${response.body}');
    }

    return jsonDecode(response.body);
  }

  void close() {
    _httpClient.close();
  }
}

Future<void> main() async {
  // Create Temporal client
  final client = TemporalClient();

  try {
    // Create user request
    final userRequest = UserRequest(
      email: 'new-user@example.com',
      firstName: 'Jane',
      lastName: 'Smith',
      role: 'admin',
    );

    // Start workflow execution
    final workflowId = await client.startWorkflow(
      workflowType: 'CreateUserWorkflow',
      taskQueue: 'user-manager-task-queue',
      workflowId: 'create-user-workflow-${userRequest.email}',
      input: userRequest.toJson(),
    );

    print('Started workflow with ID: $workflowId');

    // Get workflow result
    final result = await client.getWorkflowResult(workflowId);
    final userResponse = UserResponse.fromJson(result);

    print('User created: ID=${userResponse.id}, Email=${userResponse.email}');
  } catch (e) {
    print('Error: $e');
  } finally {
    client.close();
  }
}
```

### Workflow Execution

You can also use the Temporal Web UI to monitor and manage workflows:

1. Open the Temporal Web UI at http://localhost:8081
2. Navigate to the "Workflows" section
3. Search for workflows by ID or type

## Authentication

The service uses Keycloak for authentication and authorization. The Dapr sidecar is configured to validate Keycloak tokens.

To authenticate API requests, include a valid JWT token in the Authorization header:

```
Authorization: Bearer <your-token>
```

## Running Tests

### Unit Tests

Run unit tests with:

```bash
cd backend/user_manager
go test ./internal/... -v
```

### Integration Tests

Integration tests require a running PostgreSQL database and Temporal server:

```bash
# Start required services
docker compose up -d temporal-postgresql temporal elasticsearch

# Run integration tests
go test ./tests/integration/... -v
```

### End-to-End Tests

End-to-end tests use Gherkin feature files with Godog:

```bash
cd backend/user_manager/tests/e2e
go test -v
```

Example Gherkin feature:

```gherkin
Feature: User Management
  Scenario: Create a new user
    Given I have valid authentication
    When I create a user with email "test@example.com"
    Then the user should be saved in the database
    And I should receive a successful response
```

## Configuration

The service is configured via environment variables:

| Variable | Description | Default |
|----------|-------------|---------|
| SERVER_PORT | HTTP server port | 8080 |
| DB_HOST | PostgreSQL host | user_db |
| DB_PORT | PostgreSQL port | 5432 |
| DB_USER | PostgreSQL username | user_manager |
| DB_PASSWORD | PostgreSQL password | password |
| DB_NAME | PostgreSQL database name | user_db |
| TEMPORAL_ADDRESS | Temporal server address | temporal:7233 |
| TEMPORAL_NAMESPACE | Temporal namespace | default |
| TEMPORAL_TASK_QUEUE | Temporal task queue | user-manager-task-queue |
| KEYCLOAK_URL | Keycloak server URL | http://keycloak:8080 |

## Troubleshooting

Common issues and solutions:

1. **Connection to PostgreSQL fails**
   - Check if the PostgreSQL container is running
   - Verify the database credentials
   - Ensure the service is on the same network as PostgreSQL

2. **Temporal connection error**
   - Verify that Temporal server is running
   - Check the TEMPORAL_ADDRESS environment variable
   - Ensure the service is on the same network as Temporal

3. **Authentication fails**
   - Check if Keycloak is running
   - Verify the token is valid and not expired
   - Ensure the Dapr sidecar is properly configured
