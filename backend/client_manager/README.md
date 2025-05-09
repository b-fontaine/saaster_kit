# Client Manager Microservice

This microservice manages client information in the SaaS B2B Starter Kit.

## Features

- Add client information
- Retrieve client information
- Authentication via Keycloak
- Integration with Dapr for observability and authentication

## Architecture

The service follows a hexagonal architecture pattern:

- **Domain**: Contains the core business logic and entities
- **Ports**: Defines interfaces for interacting with the domain
- **Adapters**: Implements the interfaces defined in the ports
- **Application**: Orchestrates the flow of data between the adapters and the domain

## API Endpoints

### Add Client

```
POST /api/v1/clients
```

Request body:
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "contactEmail": "john.doe@example.com",
  "phoneNumber": "+1234567890"
}
```

### Get Client

```
GET /api/v1/clients
```

Response:
```json
{
  "uuid": "550e8400-e29b-41d4-a716-446655440000",
  "firstName": "John",
  "lastName": "Doe",
  "contactEmail": "john.doe@example.com",
  "phoneNumber": "+1234567890"
}
```

## Database

The service uses PostgreSQL with migrations managed by golang-migrate.

### Database Schema

```sql
CREATE TABLE clients (
    uuid UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

## Testing

The service uses Godog for BDD-style testing with Gherkin features.

To run the tests:

```bash
cd tests
go test -v
```

## Deployment

The service is deployed as a Docker container with a Dapr sidecar for:

- Logging to Elasticsearch
- Metrics to Prometheus
- Authentication via Keycloak

## Environment Variables

- `SERVER_PORT`: Port for the HTTP server (default: 8080)
- `DB_HOST`: Database host (default: localhost)
- `DB_PORT`: Database port (default: 5432)
- `DB_USER`: Database user (default: postgres)
- `DB_PASSWORD`: Database password
- `DB_NAME`: Database name (default: client_manager_db)
- `TEMPORAL_ADDRESS`: Temporal server address
- `TEMPORAL_NAMESPACE`: Temporal namespace
- `TEMPORAL_TASK_QUEUE`: Temporal task queue
- `KEYCLOAK_URL`: Keycloak server URL
