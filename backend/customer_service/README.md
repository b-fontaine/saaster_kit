# Customer Service Microservice

This microservice manages customer information in the SaaS B2B Starter Kit.

## Features

- Add, get, update, and list customer information
- gRPC API endpoints
- Authentication via Keycloak
- Integration with Temporal for workflow orchestration
- OpenTelemetry for observability (Elasticsearch, Prometheus)

## Architecture

The service follows a hexagonal architecture pattern with CQRS:

- **Domain**: Contains the core business logic and entities
- **Ports**: Defines interfaces for interacting with the domain
- **Adapters**: Implements the interfaces defined in the ports
- **Application**: Orchestrates the flow of data between the adapters and the domain

## API Endpoints

The service exposes the following gRPC endpoints:

### AddCustomer

```protobuf
rpc AddCustomer(AddCustomerRequest) returns (CustomerResponse);
```

### GetCustomer

```protobuf
rpc GetCustomer(GetCustomerRequest) returns (CustomerResponse);
```

### UpdateCustomer

```protobuf
rpc UpdateCustomer(UpdateCustomerRequest) returns (CustomerResponse);
```

### ListCustomers

```protobuf
rpc ListCustomers(ListCustomersRequest) returns (ListCustomersResponse);
```

## Database

The service uses PostgreSQL with migrations managed by golang-migrate.

### Database Schema

```sql
CREATE TABLE customers (
    uuid UUID PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    contact_phone VARCHAR(20) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);
```

## Temporal Workflows

The service uses Temporal for workflow orchestration:

- **AddCustomerWorkflow**: Workflow for adding a new customer
- **GetCustomerWorkflow**: Workflow for retrieving a customer
- **UpdateCustomerWorkflow**: Workflow for updating a customer
- **ListCustomersWorkflow**: Workflow for listing all customers

## Testing

The service uses Godog for BDD-style testing with Gherkin features and Testcontainers for integration testing.

To run the tests:

```bash
cd tests
go test -v
```

## Deployment

The service is deployed as a Docker container and integrates with:

- PostgreSQL for data storage
- Temporal for workflow orchestration
- Elasticsearch for logging
- Prometheus for metrics
- Keycloak for authentication

## Environment Variables

- `GRPC_PORT`: Port for the gRPC server (default: 50051)
- `DB_HOST`: Database host (default: localhost)
- `DB_PORT`: Database port (default: 5432)
- `DB_USER`: Database user (default: postgres)
- `DB_PASSWORD`: Database password
- `DB_NAME`: Database name (default: customer_service_db)
- `TEMPORAL_ADDRESS`: Temporal server address
- `TEMPORAL_NAMESPACE`: Temporal namespace
- `TEMPORAL_TASK_QUEUE`: Temporal task queue
- `OTLP_ENDPOINT`: OpenTelemetry collector endpoint
- `ELASTIC_URL`: Elasticsearch URL
- `ELASTIC_INDEX`: Elasticsearch index
- `KEYCLOAK_URL`: Keycloak URL
