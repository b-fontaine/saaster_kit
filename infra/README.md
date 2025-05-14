# Infrastructure Configuration

This directory contains all the infrastructure configuration files for the SaaS B2B Starter Kit. Each subdirectory represents a different component of the infrastructure. The infrastructure is designed to provide a complete foundation for building a SaaS application with microservices architecture, authentication, workflow orchestration, and observability.

## Directory Structure

```
infra/
├── grafana/             # Grafana Visualization Platform
│   └── provisioning/    # Grafana provisioning configuration
│       ├── dashboards/  # Pre-configured dashboards
│       └── datasources/ # Data source configurations
├── keycloak/            # Keycloak Identity and Access Management
│   ├── imports/         # Realm configuration for Keycloak
│   │   └── realm.json   # Predefined realm with users, roles, and clients
│   └── README.md        # Keycloak documentation
├── kong/                # Kong API Gateway
│   ├── docker/          # Docker build context for Kong
│   ├── kong.yml         # Kong declarative configuration
│   ├── routes.yml       # Additional route configurations
│   └── README.md        # Kong Documentation
├── prometheus/          # Prometheus Monitoring System
│   └── prometheus.yml   # Prometheus configuration
└── temporal/            # Temporal Workflow Engine
    ├── dynamicconfig/   # Temporal dynamic configuration
    │   ├── docker.yaml  # Configuration for Docker environment
    │   └── README.md    # Dynamic config documentation
    └── README.md        # Temporal documentation
```

## Component Configurations

### SafeLine (Web Application Firewall)

**Location**: `infra/safeline/`

SafeLine is a self-hosted Web Application Firewall (WAF) that protects your web applications from attacks and exploits.

**Key Features**:

- **Block Web Attacks**: Defends against SQL injection, XSS, code injection, and other common web attacks
- **Rate Limiting**: Protects against DoS attacks and brute force attempts
- **Anti-Bot Protection**: Blocks malicious bots while allowing legitimate users
- **Dynamic Protection**: Encrypts HTML and JS code to prevent client-side attacks

**Integration with Kong**:

SafeLine is integrated with Kong API Gateway using the `kong-safeline` plugin. The plugin is configured globally to protect all routes and services.

**Access**:

The SafeLine Management UI is accessible at `https://localhost:9443` with default credentials (admin/admin).

### Kong (API Gateway)

**Location**: `infra/kong/`

Kong acts as the API Gateway, managing API access, authentication, and transformations. It sits between Traefik and backend services.

**Configuration Files**:

- `kong.yml`: Declarative configuration file that defines:
  - Services: Backend services like Temporal UI, Keycloak, Grafana, and microservices
  - Routes: URL paths and their mappings to services
  - Plugins: Authentication, CORS, rate limiting, and request transformation
  - Consumers: API clients with credentials
- `routes.yml`: Additional route configurations that are merged with the main configuration

Key features configured in Kong:

- **Authentication**: OAuth2 authentication for API endpoints
- **Frontend Applications**: Routes to web UIs like Keycloak, Temporal UI, and Grafana without authentication
- **REST to gRPC Translation**: Maps REST endpoints to gRPC methods using the gRPC-Gateway plugin
- **Rate Limiting**: Prevents abuse by limiting request rates
- **CORS**: Cross-Origin Resource Sharing configuration
- **Request Transformation**: Modifies requests before they reach backend services

**Accessible Endpoints**:

| Endpoint | Description | Authentication |
|----------|-------------|---------------|
| `/` | Landing page website | No authentication required |
| `/auth/*` | Keycloak authentication service | Uses Keycloak's own authentication |
| `/temporal/*` | Temporal UI for workflow monitoring | Uses Temporal's own authentication |
| `/grafana/*` | Grafana dashboard for metrics visualization | Uses Grafana's own authentication |
| `/api/v1/customer` | Customer API (GET, PUT, POST) | OAuth2 required |
| `/api/v1/customers` | List Customers API (GET) | OAuth2 required |

### Keycloak (Identity and Access Management)

**Location**: `infra/keycloak/`

Keycloak provides OAuth2/OpenID Connect authentication and authorization services for the entire platform.

**Configuration Files**:

- `imports/realm.json`: Pre-configured realm definition that includes:
  - User definitions and roles
  - Client applications
  - Authentication flows
  - Token settings and lifespans
  - Password policies

This configuration is automatically imported when Keycloak starts, providing a ready-to-use IAM solution.

**Key Features**:

- **OAuth2/OIDC**: Standard-compliant implementation of OAuth2 and OpenID Connect
- **User Management**: Complete user lifecycle management
- **Role-Based Access Control**: Fine-grained authorization based on roles
- **Token Management**: JWT token issuance and validation
- **Client Registration**: Registration of client applications

**Access**:

Keycloak is accessible at `http://localhost/auth` through the Kong API Gateway.

### Temporal (Workflow Engine)

**Location**: `infra/temporal/`

Temporal is a workflow orchestration engine that manages long-running business processes with durability and resilience.

**Configuration Files**:

- `dynamicconfig/docker.yaml`: Runtime configuration for Temporal in Docker environment:
  - Workflow and activity timeouts
  - Retry policies
  - Task queue settings
  - Namespace-specific configurations
  - History and archival settings

**Namespaces**:

- **default**: Used for system workflows
- **customer-namespace**: Used for customer management workflows

**Key Features**:

- **Durable Execution**: Workflows continue execution even after process/node failures
- **Event Sourcing**: Records all workflow events for deterministic replay
- **Versioning**: Supports workflow code versioning for safe updates
- **Visibility**: Provides visibility into workflow execution status
- **Scalability**: Horizontally scalable architecture

**Components**:

- **Temporal Server**: Core workflow engine
- **Temporal UI**: Web interface for monitoring and managing workflows
- **Temporal Admin Tools**: CLI tools for administrative tasks
- **Workers**: Microservice components that implement and execute workflow logic

**Access**:

Temporal UI is accessible at `http://localhost/temporal` through the Kong API Gateway.

### Observability Stack (Prometheus, Grafana, Elasticsearch)

**Location**: `infra/prometheus/`, `infra/grafana/`, and Elasticsearch (configured in docker-compose.yml)

The observability stack provides comprehensive monitoring and logging capabilities for the entire system.

#### Components

1. **Elasticsearch**: Stores logs from various services
   - Configured to store logs from Dapr sidecars and microservices
   - Indexes logs with structured metadata for efficient querying
   - Accessible at http://localhost:9200

2. **Prometheus**: Collects and stores metrics
   - **Configuration File**: `prometheus/prometheus.yml`
     - Defines scrape targets (Traefik, Temporal, Dapr, Kong, microservices)
     - Configures scrape intervals and evaluation periods
     - Sets up alerting rules
   - Accessible at http://localhost:9090

3. **Grafana**: Visualizes metrics and logs
   - **Configuration Files**:
     - `grafana/provisioning/datasources/datasources.yml`: Configures Prometheus and Elasticsearch as data sources
     - `grafana/provisioning/dashboards/dashboards.yml`: Sets up dashboard provisioning
     - `grafana/provisioning/dashboards/*.json`: Pre-configured dashboards for services
   - Features:
     - Pre-configured dashboards for microservices
     - Alerting capabilities
     - User authentication
   - Accessible at `http://localhost/grafana` through the Kong API Gateway

#### OpenTelemetry Integration

Microservices are instrumented with OpenTelemetry to provide:

- **Distributed Tracing**: Track requests across service boundaries
- **Metrics**: Collect performance and business metrics
- **Logs**: Structured logging with context

#### Dapr Integration

Services are configured to send logs to Elasticsearch and metrics to Prometheus through Dapr:

- **Logs**: Configured via `elasticsearch-logging.yaml` component and Dapr's config.yaml
- **Metrics**: Exposed through the `prometheus-metrics.yaml` component

#### Adding New Services to Observability

To add a new service to the observability stack:

1. **For Logs**:
   - Configure the Dapr sidecar with the elasticsearch-logging component
   - Enable logging in the Dapr configuration

2. **For Metrics**:
   - Configure the Dapr sidecar with the prometheus-metrics component
   - Add the service to the Prometheus scrape configuration

3. **For Visualization**:
   - Create or import dashboards in Grafana
   - Configure alerts if needed

#### Troubleshooting

- **Check Elasticsearch**: `curl -X GET "localhost:9200/_cat/indices?v"`
- **Check Prometheus targets**: http://localhost:9090/targets
- **Check Dapr logs**: `docker logs user_manager_dapr`
- **Verify Grafana data sources**: http://localhost:3000/datasources

## Microservices Integration

The infrastructure components are designed to work seamlessly with the microservices in the `backend/` directory:

### Customer Service

- **Location**: `backend/customer_service/`
- **Database**: PostgreSQL with dedicated database
- **API**: gRPC endpoints with REST mapping through Kong
- **Workflows**: Temporal workflows for customer management operations
- **Observability**: OpenTelemetry integration with Elasticsearch and Prometheus

## Accessible Websites

Once the infrastructure is running, the following web interfaces are available:

| Website | URL | Description | Authentication |
|---------|-----|-------------|---------------|
| Landing Page | http://localhost/ | Main website with marketing content | No authentication required |
| Keycloak | http://localhost/auth | Identity and Access Management | Uses its own authentication |
| Temporal UI | http://localhost/temporal | Workflow monitoring and management | Uses its own authentication |
| Grafana | http://localhost/grafana | Metrics visualization | Uses its own authentication |
| Kong Admin | http://localhost:8001 | API Gateway administration | No authentication required |
| SafeLine UI | https://localhost:9443 | Web Application Firewall management | admin/admin (default) |

## Usage

These configuration files are automatically used when starting the services with Docker Compose:

```bash
docker compose -p SaaSter up -d
```

The Docker Compose file maps these configuration directories to the appropriate locations in each container.

## Customization

To customize the infrastructure:

1. **Kong**: Update `kong.yml` and `routes.yml` to add new services, routes, or modify authentication settings.

2. **SafeLine**: Access the SafeLine Management UI at `https://localhost:9443` to customize protection rules, view attack logs, and adjust security settings.

3. **Keycloak**: Edit `realm.json` to change authentication policies, add users, or configure client applications.

4. **Temporal**: Adjust `docker.yaml` to modify workflow timeouts, retry policies, or other runtime behaviors. Register new namespaces for additional microservices.

5. **Observability**: Add new dashboards to Grafana, configure additional scrape targets in Prometheus, or adjust log settings.

## Security Considerations

The current configuration is designed for development and testing. For production use:

- Replace development certificates with trusted TLS certificates
- Use more restrictive CORS policies
- Implement stronger authentication mechanisms
- Review and adjust rate limits based on expected traffic patterns
- Consider using secrets management for sensitive configuration values
- Customize SafeLine WAF rules based on your specific application needs
- Configure network policies to restrict inter-service communication
- Regularly update SafeLine to get the latest security rules and protections
