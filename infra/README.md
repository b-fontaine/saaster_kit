# Infrastructure Configuration

This directory contains all the infrastructure configuration files for the SaaS B2B Starter Kit. Each subdirectory represents a different component of the infrastructure.

## Directory Structure

```
infra/
├── keycloak/            # Keycloak Identity and Access Management
│   ├── imports/         # Realm configuration for Keycloak
│   │   └── realm.json   # Predefined realm with users, roles, and clients
│   └── README.md        # Keycloak documentation
├── kong/                # Kong API Gateway
│   ├── kong.yml         # Kong declarative configuration
│   └── README.md        # Kong Documentation
├── temporal/            # Temporal Workflow Engine
│   ├── dynamicconfig/   # Temporal dynamic configuration
│   │   ├── docker.yaml  # Configuration for Docker environment
│   │   └── README.md    # Dynamic config documentation
│   └── README.md        # Temporal documentation
└── traefik/             # Traefik Reverse Proxy and Load Balancer
    ├── config/          # Main Traefik configuration
    │   └── traefik.yml  # Global Traefik settings
    ├── dynamic/         # Dynamic Traefik configuration
    │   ├── middlewares.yml # Middleware definitions
    │   └── tls.yml      # TLS configuration
    └── README.md        # Traefik documentation    
```

## Component Configurations

### Traefik (Reverse Proxy and Load Balancer)

**Location**: `infra/traefik/`

Traefik serves as the entry point for all traffic in the system. It handles:

- **TLS Termination**: Manages HTTPS connections and certificates
- **Routing**: Directs traffic to appropriate backend services
- **Load Balancing**: Distributes traffic across service instances
- **Middleware Integration**: Connects with ModSecurity for WAF capabilities

**Configuration Files**:

- `config/traefik.yml`: Main configuration file that defines:
  - Global settings and log levels
  - Entry points (HTTP/HTTPS ports)
  - Provider configurations (Docker, File)
  - Dashboard settings
  - ModSecurity plugin integration

- `dynamic/middlewares.yml`: Defines middleware chains for request processing
- `dynamic/tls.yml`: TLS certificate configuration

### Kong (API Gateway)

**Location**: `infra/kong/`

Kong acts as the API Gateway, managing API access, authentication, and transformations. It sits between Traefik and backend services.

**Configuration Files**:

- `kong.yml`: Declarative configuration file that defines:
  - Services: Backend services like Temporal API, Temporal UI, and Keycloak
  - Routes: URL paths and their mappings to services
  - Plugins: Authentication, CORS, rate limiting, and request transformation
  - Consumers: API clients with credentials

Key features configured in Kong:

- **Authentication**: API key authentication for services
- **Rate Limiting**: Prevents abuse by limiting request rates
- **CORS**: Cross-Origin Resource Sharing configuration
- **Request Transformation**: Modifies requests before they reach backend services

### Keycloak (Identity and Access Management)

**Location**: `infra/keycloak/`

Keycloak provides OAuth2/OpenID Connect authentication and authorization services.

**Configuration Files**:

- `imports/realm.json`: Pre-configured realm definition that includes:
  - User definitions and roles
  - Client applications
  - Authentication flows
  - Token settings and lifespans
  - Password policies

This configuration is automatically imported when Keycloak starts, providing a ready-to-use IAM solution.

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

The configuration specifically includes settings for the `user-manager` namespace, which is used by the user management service.

## Usage

These configuration files are automatically used when starting the services with Docker Compose:

```bash
docker compose -p saaster up -d
```

The Docker Compose file maps these configuration directories to the appropriate locations in each container.

## Customization

To customize the infrastructure:

1. **Traefik**: Modify `traefik.yml` for global settings or the dynamic configuration files for specific routing rules and middlewares.

2. **Kong**: Update `kong.yml` to add new services, routes, or modify authentication settings.

3. **Keycloak**: Edit `realm.json` to change authentication policies, add users, or configure client applications.

4. **Temporal**: Adjust `docker.yaml` to modify workflow timeouts, retry policies, or other runtime behaviors.

## Security Considerations

The current configuration is designed for development and testing. For production use:

- Replace development certificates with trusted TLS certificates
- Use more restrictive CORS policies
- Implement stronger authentication mechanisms
- Review and adjust rate limits based on expected traffic patterns
- Consider using secrets management for sensitive configuration values
