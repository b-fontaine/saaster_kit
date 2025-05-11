# SaaSter Kit Backend

This document provides comprehensive guidance on the backend architecture of the SaaSter Kit, focusing on microservices, architectural patterns, and testing methodologies.

## Table of Contents

1. [Understanding Microservices Architecture](#understanding-microservices-architecture)
   - [Hexagonal Architecture](#hexagonal-architecture)
   - [Behavior-Driven Development (BDD) with Gherkin](#behavior-driven-development-bdd-with-gherkin)
   - [Microservice Components](#microservice-components)
2. [Creating a New Microservice: Step-by-Step Guide](#creating-a-new-microservice-step-by-step-guide)
   - [Step 1: Project Structure](#step-1-project-structure)
   - [Step 2: Domain Layer](#step-2-domain-layer)
   - [Step 3: Ports Layer](#step-3-ports-layer)
   - [Step 4: Adapters Layer](#step-4-adapters-layer)
   - [Step 5: Application Layer](#step-5-application-layer)
   - [Step 6: Temporal Workflows](#step-6-temporal-workflows)
   - [Step 7: API Endpoints](#step-7-api-endpoints)
   - [Step 8: Dapr Integration](#step-8-dapr-integration)
   - [Step 9: Observability](#step-9-observability)
   - [Step 10: Testing](#step-10-testing)
   - [Step 11: Docker Configuration](#step-11-docker-configuration)
   - [Step 12: Docker Compose Integration](#step-12-docker-compose-integration)
3. [Creating a New Microservice with Augment Code](#creating-a-new-microservice-with-augment-code)

## Understanding Microservices Architecture

The SaaSter Kit backend is built on a microservices architecture, where each service is responsible for a specific business domain. The `client_manager` service is an example of this approach, handling all client-related operations.

### Hexagonal Architecture

Each microservice in the SaaSter Kit follows the Hexagonal Architecture (also known as Ports and Adapters) pattern. This architectural style isolates the core business logic from external concerns, making the system more maintainable, testable, and adaptable to change.

#### Key Components of Hexagonal Architecture

1. **Domain Layer**: Contains the core business logic and entities.
   - Located in `internal/domain/`
   - Includes domain entities, value objects, and domain services
   - Has no dependencies on external frameworks or libraries

2. **Ports Layer**: Defines interfaces for interacting with the domain.
   - Located in `internal/ports/`
   - Divided into:
     - `in`: Interfaces that allow external systems to interact with the domain
     - `out`: Interfaces that the domain uses to interact with external systems

3. **Adapters Layer**: Implements the interfaces defined in the ports layer.
   - Located in `internal/adapters/`
   - Includes:
     - `handlers`: HTTP handlers for API endpoints
     - `repositories`: Database implementations
     - `temporal`: Temporal workflow adapters
     - `logger`: Logging adapters for Elasticsearch

4. **Application Layer**: Orchestrates the flow of data between adapters and the domain.
   - Located in `internal/application/`
   - Contains application services that coordinate use cases

#### Benefits of Hexagonal Architecture

- **Testability**: The core business logic can be tested in isolation without external dependencies
- **Flexibility**: External components can be replaced without affecting the domain logic
- **Maintainability**: Clear separation of concerns makes the codebase easier to understand and maintain
- **Technology Independence**: The domain is not tied to specific frameworks or databases

### Behavior-Driven Development (BDD) with Gherkin

The SaaSter Kit uses Behavior-Driven Development (BDD) with Gherkin for testing. This approach focuses on describing the behavior of the system in a way that is understandable by both technical and non-technical stakeholders.

#### Gherkin Features

Gherkin uses a simple, natural language syntax with keywords like `Feature`, `Scenario`, `Given`, `When`, and `Then`.

Example of a Gherkin feature file for the client_manager service:

```gherkin
Feature: Client Management
  As a system administrator
  I want to manage client information
  So that I can keep track of all clients in the system

  Scenario: Add a new client
    Given I am authenticated as an administrator
    When I add a new client with the following details:
      | First Name | Last Name | Email               | Phone        |
      | John       | Doe       | john.doe@example.com | 555-123-4567 |
    Then the client should be successfully added to the system
    And I should receive a confirmation with the client's UUID
```

#### Implementation with Godog

The SaaSter Kit uses [Godog](https://github.com/cucumber/godog), a Cucumber-like BDD framework for Go, to implement Gherkin tests.

The test implementation maps Gherkin steps to Go functions:

```go
func InitializeScenario(ctx *godog.ScenarioContext) {
    ctx.Step(`^I am authenticated as an administrator$`, iAmAuthenticatedAsAdmin)
    ctx.Step(`^I add a new client with the following details:$`, iAddANewClientWithDetails)
    ctx.Step(`^the client should be successfully added to the system$`, theClientShouldBeSuccessfullyAdded)
    ctx.Step(`^I should receive a confirmation with the client's UUID$`, iShouldReceiveConfirmationWithUUID)
}
```

#### Benefits of BDD with Gherkin

- **Shared Understanding**: Features are written in natural language that all stakeholders can understand
- **Living Documentation**: Tests serve as up-to-date documentation of system behavior
- **Focus on Business Value**: Tests are written from the user's perspective, focusing on business requirements
- **Reduced Translation Errors**: Less chance of misinterpreting requirements when translating to code

### Microservice Components

Each microservice in the SaaSter Kit integrates with several technologies to provide a complete solution:

#### 1. Temporal Workflows

Temporal is used for orchestrating long-running, fault-tolerant business processes. In the client_manager service:

- **Workflows**: Define the sequence of activities (e.g., `AddClientWorkflow`, `GetClientWorkflow`)
- **Activities**: Implement individual steps in the workflow (e.g., `AddClientActivity`, `GetClientActivity`)
- **Workers**: Process tasks from specific task queues
- **Namespaces**: Isolate workflows for different domains (e.g., `client-namespace`)

Temporal provides:
- Durability against process failures
- Automatic retries for failed activities
- Versioning for workflow changes
- Visibility into workflow execution

#### 2. Dapr Sidecars

Distributed Application Runtime (Dapr) provides building blocks for microservices:

- **Service Invocation**: For service-to-service communication
- **State Management**: For storing and retrieving state
- **Pub/Sub Messaging**: For event-driven architecture
- **Bindings**: For interacting with external systems (e.g., Elasticsearch for logging)
- **Observability**: For tracing, metrics, and logging
- **Security**: For authentication and authorization with Keycloak

#### 3. Observability Stack

The SaaSter Kit includes a comprehensive observability stack:

- **Elasticsearch**: Stores and indexes logs from all microservices
- **Prometheus**: Collects and stores metrics
- **Grafana**: Visualizes metrics and logs

#### 4. Database

Each microservice has its own PostgreSQL database, following the database-per-service pattern:

- **Migrations**: Managed with golang-migrate
- **Repositories**: Implement data access using the hexagonal architecture pattern
- **Connection Pooling**: Configured for optimal performance

#### 5. API Gateway

The SaaSter Kit uses Kong as an API gateway:

- **Routing**: Directs requests to appropriate microservices
- **Authentication**: Integrates with Keycloak for token validation
- **Rate Limiting**: Protects services from overload
- **Logging**: Captures API request/response data

#### 6. Security

Security is implemented at multiple levels:

- **Keycloak**: Provides OAuth2/OpenID Connect authentication and authorization
- **Dapr**: Validates tokens and enforces access control
- **ModSecurity WAF**: Protects against common web attacks
- **TLS**: Encrypts communication between services

## Creating a New Microservice: Step-by-Step Guide

This section provides a detailed, step-by-step guide for creating a new microservice in the SaaSter Kit, following the same patterns and practices as the `client_manager` service.

### Step 1: Project Structure

Start by creating the basic directory structure for your microservice:

```bash
# Replace 'service_name' with your microservice name (e.g., 'user_manager', 'billing_service', etc.)
MICROSERVICE_NAME="service_name"

# Create the main directory
mkdir -p backend/$MICROSERVICE_NAME
cd backend/$MICROSERVICE_NAME

# Create the standard directory structure
mkdir -p cmd
mkdir -p internal/domain/entities
mkdir -p internal/domain/valueobjects
mkdir -p internal/ports/in
mkdir -p internal/ports/out
mkdir -p internal/adapters/handlers
mkdir -p internal/adapters/repositories
mkdir -p internal/adapters/temporal
mkdir -p internal/adapters/logger
mkdir -p internal/application/services
mkdir -p internal/workflows
mkdir -p migrations
mkdir -p tests/features
mkdir -p tests/steps
mkdir -p deployments/dapr/components
mkdir -p deployments/dapr/config
mkdir -p scripts
```

Create the initial configuration files:

```bash
# Create go.mod file
go mod init github.com/b-fontaine/saaster_kit/backend/$MICROSERVICE_NAME

# Create Dockerfile
touch Dockerfile

# Create Makefile
touch Makefile

# Create README.md
touch README.md
```

### Step 2: Domain Layer

The domain layer contains the core business logic and entities of your microservice. This is the heart of your application and should be independent of any external frameworks or libraries.

1. **Define Domain Entities**

Create a domain entity in `internal/domain/entities/entity.go`. For example, if you're creating a `product_manager` service:

```go
package entities

import (
	"time"

	"github.com/google/uuid"
)

// Product represents a product in the system
type Product struct {
	UUID        uuid.UUID `json:"uuid"`
	Name        string    `json:"name"`
	Description string    `json:"description"`
	Price       float64   `json:"price"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

// NewProduct creates a new product with the given details
func NewProduct(id uuid.UUID, name, description string, price float64) *Product {
	now := time.Now().UTC()
	return &Product{
		UUID:        id,
		Name:        name,
		Description: description,
		Price:       price,
		CreatedAt:   now,
		UpdatedAt:   now,
	}
}

// IsEmpty checks if the product is empty
func (p *Product) IsEmpty() bool {
	return p.UUID == uuid.Nil
}
```

2. **Define Value Objects** (if needed)

Value objects are immutable objects that have no identity. They are defined by their attributes.

```go
// internal/domain/valueobjects/money.go
package valueobjects

// Money represents a monetary value with currency
type Money struct {
	Amount   float64
	Currency string
}

// NewMoney creates a new Money value object
func NewMoney(amount float64, currency string) Money {
	return Money{
		Amount:   amount,
		Currency: currency,
	}
}
```

### Step 3: Ports Layer

The ports layer defines interfaces for interacting with the domain. It's divided into "in" ports (used by external systems to interact with the domain) and "out" ports (used by the domain to interact with external systems).

1. **Define Input Ports**

Create interfaces in `internal/ports/in/service.go` that define how external systems can interact with your domain:

```go
package in

import (
	"context"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/google/uuid"
)

// ProductService defines the interface for product operations
type ProductService interface {
	// AddProduct adds a new product
	AddProduct(ctx context.Context, product *entities.Product) error

	// GetProduct retrieves a product by UUID
	GetProduct(ctx context.Context, id uuid.UUID) (*entities.Product, error)

	// UpdateProduct updates an existing product
	UpdateProduct(ctx context.Context, product *entities.Product) error

	// DeleteProduct deletes a product by UUID
	DeleteProduct(ctx context.Context, id uuid.UUID) error

	// ListProducts lists all products
	ListProducts(ctx context.Context) ([]*entities.Product, error)
}
```

2. **Define Output Ports**

Create interfaces in `internal/ports/out/repository.go` that define how your domain interacts with external systems:

```go
package out

import (
	"context"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/google/uuid"
)

// ProductRepository defines the interface for product data access
type ProductRepository interface {
	// Save saves a product
	Save(ctx context.Context, product *entities.Product) error

	// FindByID finds a product by UUID
	FindByID(ctx context.Context, id uuid.UUID) (*entities.Product, error)

	// Update updates an existing product
	Update(ctx context.Context, product *entities.Product) error

	// Delete deletes a product by UUID
	Delete(ctx context.Context, id uuid.UUID) error

	// FindAll returns all products
	FindAll(ctx context.Context) ([]*entities.Product, error)
}
```

### Step 4: Adapters Layer

The adapters layer implements the interfaces defined in the ports layer. This is where you connect your domain to external systems like databases, APIs, and message queues.

1. **Implement Repository Adapters**

Create a repository implementation in `internal/adapters/repositories/product_repository.go`:

```go
package repositories

import (
	"context"
	"database/sql"
	"fmt"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/google/uuid"
)

// ProductRepository implements the product repository interface
type ProductRepository struct {
	db *sql.DB
}

// NewProductRepository creates a new product repository
func NewProductRepository(db *sql.DB) *ProductRepository {
	return &ProductRepository{
		db: db,
	}
}

// Save saves a product to the database
func (r *ProductRepository) Save(ctx context.Context, product *entities.Product) error {
	query := `
		INSERT INTO products (uuid, name, description, price, created_at, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6)
	`

	_, err := r.db.ExecContext(
		ctx,
		query,
		product.UUID,
		product.Name,
		product.Description,
		product.Price,
		product.CreatedAt,
		product.UpdatedAt,
	)

	return err
}

// FindByID finds a product by UUID
func (r *ProductRepository) FindByID(ctx context.Context, id uuid.UUID) (*entities.Product, error) {
	query := `
		SELECT uuid, name, description, price, created_at, updated_at
		FROM products
		WHERE uuid = $1
	`

	var product entities.Product
	var createdAt, updatedAt time.Time

	err := r.db.QueryRowContext(ctx, query, id).Scan(
		&product.UUID,
		&product.Name,
		&product.Description,
		&product.Price,
		&createdAt,
		&updatedAt,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			return &entities.Product{}, nil
		}
		return nil, fmt.Errorf("error finding product: %w", err)
	}

	product.CreatedAt = createdAt
	product.UpdatedAt = updatedAt

	return &product, nil
}

// Additional methods for Update, Delete, and FindAll would be implemented here
```

2. **Implement HTTP Handlers**

Create HTTP handlers in `internal/adapters/handlers/product_handler.go`:

```go
package handlers

import (
	"net/http"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/adapters/temporal"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/ports/in"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// ProductHandler handles HTTP requests for product operations
type ProductHandler struct {
	productService in.ProductService
	temporalClient *temporal.TemporalClient
}

// NewProductHandler creates a new product handler
func NewProductHandler(productService in.ProductService, temporalClient *temporal.TemporalClient) *ProductHandler {
	return &ProductHandler{
		productService: productService,
		temporalClient: temporalClient,
	}
}

// ProductRequest represents the request body for product operations
type ProductRequest struct {
	Name        string  `json:"name" binding:"required"`
	Description string  `json:"description"`
	Price       float64 `json:"price" binding:"required,gt=0"`
}

// AddProduct handles the request to add a new product
func (h *ProductHandler) AddProduct(c *gin.Context) {
	// Get user ID from context (set by auth middleware)
	userID, exists := c.Get("userID")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "User not authenticated"})
		return
	}

	// Parse request body
	var productRequest ProductRequest
	if err := c.ShouldBindJSON(&productRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Create product entity
	product := entities.NewProduct(
		uuid.New(),
		productRequest.Name,
		productRequest.Description,
		productRequest.Price,
	)

	// Try to save product using Temporal workflow if available
	if h.temporalClient != nil {
		result, err := h.temporalClient.AddProduct(c.Request.Context(), product)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to process request"})
			return
		}

		// Return the result
		c.JSON(http.StatusOK, result)
		return
	}

	// Direct service call if Temporal is not available
	err := h.productService.AddProduct(c.Request.Context(), product)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to add product"})
		return
	}

	c.JSON(http.StatusOK, product)
}

// Additional handler methods for GetProduct, UpdateProduct, DeleteProduct, and ListProducts would be implemented here
```

3. **Implement Temporal Adapter**

Create a Temporal client adapter in `internal/adapters/temporal/client.go`:

```go
package temporal

import (
	"context"
	"fmt"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/google/uuid"
	"go.temporal.io/api/workflowservice/v1"
	"go.temporal.io/sdk/client"
)

// TemporalClient is a client for Temporal workflows
type TemporalClient struct {
	client    client.Client
	namespace string
	taskQueue string
}

// NewTemporalClient creates a new Temporal client
func NewTemporalClient(temporalAddress, namespace, taskQueue string) (*TemporalClient, error) {
	// Create namespace client
	nsClient, err := client.NewNamespaceClient(client.Options{
		HostPort: temporalAddress,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to create Temporal namespace client: %w", err)
	}

	// Register namespace
	err = nsClient.Register(context.Background(), &workflowservice.RegisterNamespaceRequest{
		Namespace: namespace,
	})
	if err != nil && !isNamespaceAlreadyExistsError(err) {
		return nil, fmt.Errorf("failed to register Temporal namespace: %w", err)
	}

	// Create workflow client
	c, err := client.Dial(client.Options{
		HostPort:  temporalAddress,
		Namespace: namespace,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to create Temporal client: %w", err)
	}

	return &TemporalClient{
		client:    c,
		namespace: namespace,
		taskQueue: taskQueue,
	}, nil
}

// isNamespaceAlreadyExistsError checks if the error is a "namespace already exists" error
func isNamespaceAlreadyExistsError(err error) bool {
	return err != nil && err.Error() == "namespace already exists"
}

// Close closes the Temporal client
func (c *TemporalClient) Close() {
	if c.client != nil {
		c.client.Close()
	}
}

// AddProduct executes the AddProduct workflow
func (c *TemporalClient) AddProduct(ctx context.Context, product *entities.Product) (*entities.Product, error) {
	options := client.StartWorkflowOptions{
		ID:        fmt.Sprintf("add-product-%s", product.UUID.String()),
		TaskQueue: c.taskQueue,
	}

	run, err := c.client.ExecuteWorkflow(ctx, options, "AddProductWorkflow", product)
	if err != nil {
		return nil, fmt.Errorf("failed to execute AddProduct workflow: %w", err)
	}

	// Wait for workflow completion
	var result entities.Product
	if err := run.Get(ctx, &result); err != nil {
		return nil, fmt.Errorf("workflow execution failed: %w", err)
	}

	return &result, nil
}

// Additional methods for other workflows would be implemented here
```

4. **Implement Logger Adapter**

Create a logger adapter in `internal/adapters/logger/logger.go`:

```go
package logger

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	dapr "github.com/dapr/go-sdk/client"
)

// Logger is a structured logger that sends logs to Dapr
type Logger struct {
	daprClient  dapr.Client
	serviceName string
	defaultFields map[string]interface{}
}

// LogLevel represents the severity of the log message
type LogLevel string

const (
	// Debug level for detailed information
	Debug LogLevel = "debug"
	// Info level for general operational information
	Info LogLevel = "info"
	// Warn level for warning conditions
	Warn LogLevel = "warn"
	// Error level for error conditions
	Error LogLevel = "error"
	// Fatal level for fatal conditions
	Fatal LogLevel = "fatal"
)

// LogEntry represents a structured log entry
type LogEntry struct {
	Level     string                 `json:"level"`
	Message   string                 `json:"msg"`
	Timestamp string                 `json:"time"`
	Service   string                 `json:"service"`
	TraceID   string                 `json:"trace_id,omitempty"`
	SpanID    string                 `json:"span_id,omitempty"`
	Fields    map[string]interface{} `json:"fields,omitempty"`
}

// NewLogger creates a new structured logger
func NewLogger(daprClient dapr.Client, serviceName string) *Logger {
	return &Logger{
		daprClient:    daprClient,
		serviceName:   serviceName,
		defaultFields: make(map[string]interface{}),
	}
}

// WithFields adds default fields to the logger
func (l *Logger) WithFields(fields map[string]interface{}) *Logger {
	newLogger := &Logger{
		daprClient:    l.daprClient,
		serviceName:   l.serviceName,
		defaultFields: make(map[string]interface{}),
	}

	// Copy existing default fields
	for k, v := range l.defaultFields {
		newLogger.defaultFields[k] = v
	}

	// Add new fields
	for k, v := range fields {
		newLogger.defaultFields[k] = v
	}

	return newLogger
}

// log sends a log entry to Dapr
func (l *Logger) log(ctx context.Context, level LogLevel, msg string, fields map[string]interface{}) {
	// Create log entry
	entry := LogEntry{
		Level:     string(level),
		Message:   msg,
		Timestamp: time.Now().UTC().Format(time.RFC3339),
		Service:   l.serviceName,
		Fields:    make(map[string]interface{}),
	}

	// Add trace context if available
	if ctx != nil {
		if traceID, ok := ctx.Value("trace_id").(string); ok {
			entry.TraceID = traceID
		}
		if spanID, ok := ctx.Value("span_id").(string); ok {
			entry.SpanID = spanID
		}
	}

	// Add default fields
	for k, v := range l.defaultFields {
		entry.Fields[k] = v
	}

	// Add additional fields
	for k, v := range fields {
		entry.Fields[k] = v
	}

	// Convert to JSON
	jsonData, err := json.Marshal(entry)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error marshaling log entry: %v\n", err)
		return
	}

	// Send to Dapr
	if l.daprClient != nil {
		// Create metadata for the HTTP binding
		metadata := map[string]string{
			"Content-Type": "application/json",
		}

		// Send to Elasticsearch via HTTP binding
		_, err = l.daprClient.InvokeBinding(ctx, &dapr.InvokeBindingRequest{
			Name:      "elasticsearch-logs",
			Operation: "post",
			Data:      jsonData,
			Metadata:  metadata,
		})
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error sending log to Dapr: %v\n", err)
		}
	}

	// Also print to stdout for local development
	fmt.Println(string(jsonData))
}

// Debug logs a debug message
func (l *Logger) Debug(ctx context.Context, msg string, fields map[string]interface{}) {
	l.log(ctx, Debug, msg, fields)
}

// Info logs an info message
func (l *Logger) Info(ctx context.Context, msg string, fields map[string]interface{}) {
	l.log(ctx, Info, msg, fields)
}

// Warn logs a warning message
func (l *Logger) Warn(ctx context.Context, msg string, fields map[string]interface{}) {
	l.log(ctx, Warn, msg, fields)
}

// Error logs an error message
func (l *Logger) Error(ctx context.Context, msg string, err error, fields map[string]interface{}) {
	if fields == nil {
		fields = make(map[string]interface{})
	}
	if err != nil {
		fields["error"] = err.Error()
	}
	l.log(ctx, Error, msg, fields)
}

// Fatal logs a fatal message and exits
func (l *Logger) Fatal(ctx context.Context, msg string, err error, fields map[string]interface{}) {
	if fields == nil {
		fields = make(map[string]interface{})
	}
	if err != nil {
		fields["error"] = err.Error()
	}
	l.log(ctx, Fatal, msg, fields)
	os.Exit(1)
}
```

### Step 5: Application Layer

The application layer orchestrates the flow of data between adapters and the domain. It implements the service interfaces defined in the ports layer.

1. **Implement Service**

Create a service implementation in `internal/application/services/product_service.go`:

```go
package services

import (
	"context"
	"fmt"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/ports/out"
	"github.com/google/uuid"
)

// ProductService implements the product service interface
type ProductService struct {
	productRepo out.ProductRepository
}

// NewProductService creates a new product service
func NewProductService(productRepo out.ProductRepository) *ProductService {
	return &ProductService{
		productRepo: productRepo,
	}
}

// AddProduct adds a new product to the system
func (s *ProductService) AddProduct(ctx context.Context, product *entities.Product) error {
	// Check if product already exists
	existingProduct, err := s.productRepo.FindByID(ctx, product.UUID)
	if err != nil {
		return fmt.Errorf("error checking existing product: %w", err)
	}

	if existingProduct != nil && !existingProduct.IsEmpty() {
		// Update existing product
		return s.productRepo.Update(ctx, product)
	}

	// Save new product
	return s.productRepo.Save(ctx, product)
}

// GetProduct retrieves a product by UUID
func (s *ProductService) GetProduct(ctx context.Context, id uuid.UUID) (*entities.Product, error) {
	product, err := s.productRepo.FindByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("error retrieving product: %w", err)
	}

	return product, nil
}

// UpdateProduct updates an existing product
func (s *ProductService) UpdateProduct(ctx context.Context, product *entities.Product) error {
	// Check if product exists
	existingProduct, err := s.productRepo.FindByID(ctx, product.UUID)
	if err != nil {
		return fmt.Errorf("error checking existing product: %w", err)
	}

	if existingProduct == nil || existingProduct.IsEmpty() {
		return fmt.Errorf("product not found")
	}

	// Update product
	return s.productRepo.Update(ctx, product)
}

// DeleteProduct deletes a product by UUID
func (s *ProductService) DeleteProduct(ctx context.Context, id uuid.UUID) error {
	// Check if product exists
	existingProduct, err := s.productRepo.FindByID(ctx, id)
	if err != nil {
		return fmt.Errorf("error checking existing product: %w", err)
	}

	if existingProduct == nil || existingProduct.IsEmpty() {
		return fmt.Errorf("product not found")
	}

	// Delete product
	return s.productRepo.Delete(ctx, id)
}

// ListProducts lists all products
func (s *ProductService) ListProducts(ctx context.Context) ([]*entities.Product, error) {
	products, err := s.productRepo.FindAll(ctx)
	if err != nil {
		return nil, fmt.Errorf("error listing products: %w", err)
	}

	return products, nil
}
```

### Step 6: Temporal Workflows

Temporal workflows provide durable, fault-tolerant execution of business processes. They're especially useful for long-running operations and processes that need to survive service restarts.

1. **Define Workflow Interfaces**

Create workflow interfaces in `internal/workflows/workflow.go`:

```go
package workflows

import (
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/google/uuid"
	"go.temporal.io/sdk/workflow"
)

// ProductWorkflow defines the interface for product workflows
type ProductWorkflow interface {
	// AddProduct adds a new product
	AddProduct(ctx workflow.Context, product *entities.Product) (*entities.Product, error)

	// GetProduct retrieves a product by UUID
	GetProduct(ctx workflow.Context, id uuid.UUID) (*entities.Product, error)

	// UpdateProduct updates an existing product
	UpdateProduct(ctx workflow.Context, product *entities.Product) (*entities.Product, error)

	// DeleteProduct deletes a product by UUID
	DeleteProduct(ctx workflow.Context, id uuid.UUID) (bool, error)
}
```

2. **Implement Workflow Functions**

Create workflow implementations in `internal/workflows/product_workflow.go`:

```go
package workflows

import (
	"time"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/google/uuid"
	"go.temporal.io/sdk/temporal"
	"go.temporal.io/sdk/workflow"
)

// AddProductWorkflow is the workflow for adding a product
func AddProductWorkflow(ctx workflow.Context, product *entities.Product) (*entities.Product, error) {
	logger := workflow.GetLogger(ctx)
	logger.Info("AddProductWorkflow started", "productUUID", product.UUID)

	activityOptions := workflow.ActivityOptions{
		StartToCloseTimeout: 10 * time.Second,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}

	// Set workflow timeout
	ctx = workflow.WithActivityOptions(ctx, activityOptions)

	// Execute the AddProduct activity
	var result entities.Product
	err := workflow.ExecuteActivity(ctx, "AddProductActivity", product).Get(ctx, &result)
	if err != nil {
		logger.Error("AddProductWorkflow failed", "error", err)
		return nil, err
	}

	logger.Info("AddProductWorkflow completed successfully", "productUUID", result.UUID)
	return &result, nil
}

// GetProductWorkflow is the workflow for retrieving a product
func GetProductWorkflow(ctx workflow.Context, id uuid.UUID) (*entities.Product, error) {
	logger := workflow.GetLogger(ctx)
	logger.Info("GetProductWorkflow started", "productUUID", id)

	activityOptions := workflow.ActivityOptions{
		StartToCloseTimeout: 10 * time.Second,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}

	// Set workflow timeout
	ctx = workflow.WithActivityOptions(ctx, activityOptions)

	// Execute the GetProduct activity
	var result entities.Product
	err := workflow.ExecuteActivity(ctx, "GetProductActivity", id).Get(ctx, &result)
	if err != nil {
		logger.Error("GetProductWorkflow failed", "error", err)
		return nil, err
	}

	logger.Info("GetProductWorkflow completed successfully", "productUUID", id)
	return &result, nil
}

// Additional workflow implementations for UpdateProduct and DeleteProduct would be added here
```

3. **Implement Activities**

Create activity implementations in `internal/workflows/product_activity.go`:

```go
package workflows

import (
	"context"
	"fmt"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/ports/in"
	"github.com/google/uuid"
	"go.temporal.io/sdk/activity"
)

// ProductActivity defines the activities for product operations
type ProductActivity struct {
	productService in.ProductService
}

// NewProductActivity creates a new product activity
func NewProductActivity(productService in.ProductService) *ProductActivity {
	return &ProductActivity{
		productService: productService,
	}
}

// AddProductActivity adds a new product
func (a *ProductActivity) AddProductActivity(ctx context.Context, product *entities.Product) (*entities.Product, error) {
	logger := activity.GetLogger(ctx)
	logger.Info("AddProductActivity started", "productUUID", product.UUID)

	// Validate product data
	if product.UUID == uuid.Nil {
		return nil, fmt.Errorf("product UUID is required")
	}
	if product.Name == "" {
		return nil, fmt.Errorf("product name is required")
	}

	// Add product
	err := a.productService.AddProduct(ctx, product)
	if err != nil {
		logger.Error("Failed to add product", "error", err)
		return nil, fmt.Errorf("failed to add product: %w", err)
	}

	// Get the product to return the complete data
	result, err := a.productService.GetProduct(ctx, product.UUID)
	if err != nil {
		logger.Error("Failed to retrieve product after adding", "error", err)
		return nil, fmt.Errorf("failed to retrieve product after adding: %w", err)
	}

	logger.Info("AddProductActivity completed successfully", "productUUID", result.UUID)
	return result, nil
}

// GetProductActivity retrieves a product by UUID
func (a *ProductActivity) GetProductActivity(ctx context.Context, id uuid.UUID) (*entities.Product, error) {
	logger := activity.GetLogger(ctx)
	logger.Info("GetProductActivity started", "productUUID", id)

	// Validate UUID
	if id == uuid.Nil {
		return nil, fmt.Errorf("product UUID is required")
	}

	// Get product
	product, err := a.productService.GetProduct(ctx, id)
	if err != nil {
		logger.Error("Failed to retrieve product", "error", err)
		return nil, fmt.Errorf("failed to retrieve product: %w", err)
	}

	logger.Info("GetProductActivity completed successfully", "productUUID", id)
	return product, nil
}

// Additional activity implementations for UpdateProduct and DeleteProduct would be added here
```

4. **Implement Worker**

Create a worker implementation in `internal/workflows/worker.go`:

```go
package workflows

import (
	"fmt"
	"log"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/ports/in"
	"go.temporal.io/sdk/client"
	"go.temporal.io/sdk/worker"
)

// WorkerConfig holds the configuration for the Temporal worker
type WorkerConfig struct {
	TemporalAddress string
	Namespace       string
	TaskQueue       string
	ProductService  in.ProductService
}

// StartWorker starts a Temporal worker
func StartWorker(config WorkerConfig) (client.Client, error) {
	// Create Temporal client
	c, err := client.Dial(client.Options{
		HostPort:  config.TemporalAddress,
		Namespace: config.Namespace,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to create Temporal client: %w", err)
	}

	// Create worker
	w := worker.New(c, config.TaskQueue, worker.Options{})

	// Register workflows
	w.RegisterWorkflow(AddProductWorkflow)
	w.RegisterWorkflow(GetProductWorkflow)
	// Register additional workflows here

	// Create and register activities
	activities := NewProductActivity(config.ProductService)
	w.RegisterActivity(activities.AddProductActivity)
	w.RegisterActivity(activities.GetProductActivity)
	// Register additional activities here

	// Start worker
	err = w.Start()
	if err != nil {
		c.Close()
		return nil, fmt.Errorf("failed to start worker: %w", err)
	}

	log.Printf("Temporal worker started. Namespace: %s, Task Queue: %s", config.Namespace, config.TaskQueue)
	return c, nil
}
```

### Step 7: API Endpoints

API endpoints expose your microservice functionality to the outside world. In the SaaSter Kit, we use the Gin framework to create RESTful APIs.

1. **Create Main Entry Point**

Create the main entry point in `cmd/main.go`:

```go
package main

import (
	"context"
	"database/sql"
	"fmt"
	"net/http"
	"os"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/adapters/handlers"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/adapters/logger"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/adapters/repositories"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/adapters/temporal"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/application/services"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/workflows"
	dapr "github.com/dapr/go-sdk/client"
	"github.com/gin-gonic/gin"
	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	_ "github.com/lib/pq"
)

func main() {
	// Get environment variables
	dbHost := getEnv("DB_HOST", "localhost")
	dbPort := getEnv("DB_PORT", "5432")
	dbUser := getEnv("DB_USER", "postgres")
	dbPassword := getEnv("DB_PASSWORD", "password")
	dbName := getEnv("DB_NAME", "product_manager_db")
	serverPort := getEnv("SERVER_PORT", "8080")
	temporalAddress := getEnv("TEMPORAL_ADDRESS", "localhost:7233")
	temporalNamespace := getEnv("TEMPORAL_NAMESPACE", "product-namespace")
	temporalTaskQueue := getEnv("TEMPORAL_TASK_QUEUE", "product-manager-task-queue")

	// Initialize context
	ctx := context.Background()

	// Initialize Dapr client
	daprClient, err := dapr.NewClient()
	if err != nil {
		fmt.Printf("Failed to create Dapr client: %v\n", err)
		os.Exit(1)
	}
	defer daprClient.Close()

	// Initialize structured logger
	appLogger := logger.NewLogger(daprClient, "product-manager")
	appLogger.Info(ctx, "Starting product_manager service", map[string]interface{}{
		"version": "1.0.0",
	})

	// Connect to the database
	dbURL := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable",
		dbUser, dbPassword, dbHost, dbPort, dbName)

	db, err := sql.Open("postgres", dbURL)
	if err != nil {
		appLogger.Fatal(ctx, "Failed to connect to database", err, nil)
	}
	defer db.Close()

	// Set connection pool parameters
	db.SetMaxOpenConns(25)
	db.SetMaxIdleConns(5)
	db.SetConnMaxLifetime(5 * time.Minute)

	// Check database connection
	dbCtx, cancel := context.WithTimeout(ctx, 5*time.Second)
	defer cancel()

	if err := db.PingContext(dbCtx); err != nil {
		appLogger.Fatal(ctx, "Failed to ping database", err, nil)
	}
	appLogger.Info(ctx, "Connected to database successfully", nil)

	// Run database migrations
	if err := runMigrations(db); err != nil {
		appLogger.Fatal(ctx, "Failed to run migrations", err, nil)
	}
	appLogger.Info(ctx, "Migrations completed successfully", nil)

	// Initialize repositories
	productRepo := repositories.NewProductRepository(db)

	// Initialize services
	productService := services.NewProductService(productRepo)

	// Initialize Temporal client with retries
	var temporalClient *temporal.TemporalClient
	var temporalErr error
	for i := 0; i < 5; i++ {
		temporalClient, temporalErr = temporal.NewTemporalClient(temporalAddress, temporalNamespace, temporalTaskQueue)
		if temporalErr == nil {
			break
		}
		appLogger.Warn(ctx, "Failed to create Temporal client, retrying", map[string]interface{}{
			"attempt": i + 1,
			"error":   temporalErr.Error(),
			"retry_in": "5 seconds",
		})
		time.Sleep(5 * time.Second)
	}

	if temporalErr != nil {
		appLogger.Error(ctx, "Could not connect to Temporal after multiple attempts", temporalErr, map[string]interface{}{
			"impact": "The application will start without Temporal integration",
		})
	} else {
		defer temporalClient.Close()

		// Start Temporal worker
		workerConfig := workflows.WorkerConfig{
			TemporalAddress: temporalAddress,
			Namespace:       temporalNamespace,
			TaskQueue:       temporalTaskQueue,
			ProductService:  productService,
		}

		_, workerErr := workflows.StartWorker(workerConfig)
		if workerErr != nil {
			appLogger.Error(ctx, "Failed to start Temporal worker", workerErr, map[string]interface{}{
				"impact": "The application will start without Temporal worker",
			})
		} else {
			appLogger.Info(ctx, "Temporal worker started successfully", map[string]interface{}{
				"namespace": temporalNamespace,
				"taskQueue": temporalTaskQueue,
			})
		}
	}

	// Initialize handlers
	productHandler := handlers.NewProductHandler(productService, temporalClient)

	// Set up Gin router with the logger middleware
	router := gin.New()

	// Add middleware
	router.Use(gin.Recovery())

	// Add custom logging middleware
	router.Use(func(c *gin.Context) {
		start := time.Now()
		path := c.Request.URL.Path
		method := c.Request.Method

		c.Next()

		latency := time.Since(start)
		status := c.Writer.Status()

		logFields := map[string]interface{}{
			"method":   method,
			"path":     path,
			"status":   status,
			"latency":  latency.String(),
			"client_ip": c.ClientIP(),
		}

		if status >= 400 {
			appLogger.Error(ctx, "API request failed", nil, logFields)
		} else {
			appLogger.Info(ctx, "API request completed", logFields)
		}
	})

	// Define API routes
	api := router.Group("/api/v1")
	{
		// Protected routes
		protected := api.Group("/products")
		protected.Use(handlers.KeycloakAuthMiddleware(daprClient))
		{
			protected.POST("", productHandler.AddProduct)
			protected.GET("", productHandler.ListProducts)
			protected.GET("/:id", productHandler.GetProduct)
			protected.PUT("/:id", productHandler.UpdateProduct)
			protected.DELETE("/:id", productHandler.DeleteProduct)
		}

		// Health check
		api.GET("/health", func(c *gin.Context) {
			c.JSON(http.StatusOK, gin.H{"status": "ok"})
		})
	}

	// Start the server
	appLogger.Info(ctx, "Starting server", map[string]interface{}{
		"port": serverPort,
	})
	if err := router.Run(":" + serverPort); err != nil {
		appLogger.Fatal(ctx, "Failed to start server", err, nil)
	}
}

// runMigrations runs database migrations
func runMigrations(db *sql.DB) error {
	driver, err := postgres.WithInstance(db, &postgres.Config{})
	if err != nil {
		return fmt.Errorf("failed to create migration driver: %w", err)
	}

	m, err := migrate.NewWithDatabaseInstance(
		"file://migrations",
		"postgres", driver)
	if err != nil {
		return fmt.Errorf("failed to create migration instance: %w", err)
	}

	if err := m.Up(); err != nil && err != migrate.ErrNoChange {
		return fmt.Errorf("failed to run migrations: %w", err)
	}

	return nil
}

// getEnv gets an environment variable or returns a default value
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}
```

2. **Implement Authentication Middleware**

Create an authentication middleware in `internal/adapters/handlers/auth_middleware.go`:

```go
package handlers

import (
	"context"
	"net/http"
	"strings"

	dapr "github.com/dapr/go-sdk/client"
	"github.com/gin-gonic/gin"
)

// KeycloakAuthMiddleware validates JWT tokens using Dapr and Keycloak
func KeycloakAuthMiddleware(daprClient dapr.Client) gin.HandlerFunc {
	return func(c *gin.Context) {
		// Get the Authorization header
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization header is required"})
			c.Abort()
			return
		}

		// Check if the header has the Bearer prefix
		if !strings.HasPrefix(authHeader, "Bearer ") {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization header must be Bearer token"})
			c.Abort()
			return
		}

		// Extract the token
		token := strings.TrimPrefix(authHeader, "Bearer ")

		// Call Dapr sidecar to validate the token with Keycloak
		content := &dapr.DataContent{
			ContentType: "application/json",
			Data:        []byte(token),
		}

		resp, err := daprClient.InvokeBinding(context.Background(), &dapr.InvokeBindingRequest{
			Name:      "keycloak-auth",
			Operation: "validate",
			Data:      content.Data,
		})

		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Failed to validate token"})
			c.Abort()
			return
		}

		// Parse the response to get user ID
		userID := string(resp.Data)
		if userID == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
			c.Abort()
			return
		}

		// Set the user ID in the context
		c.Set("userID", userID)
		c.Next()
	}
}
```

3. **Implement Additional Handler Methods**

Add the remaining handler methods to `internal/adapters/handlers/product_handler.go`:

```go
// GetProduct handles the request to get a product by ID
func (h *ProductHandler) GetProduct(c *gin.Context) {
	// Get product ID from URL parameter
	idStr := c.Param("id")
	id, err := uuid.Parse(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid product ID"})
		return
	}

	// Try to get product using Temporal workflow if available
	if h.temporalClient != nil {
		result, err := h.temporalClient.GetProduct(c.Request.Context(), id)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to process request"})
			return
		}

		// Check if product exists
		if result.IsEmpty() {
			c.JSON(http.StatusNotFound, gin.H{"error": "Product not found"})
			return
		}

		// Return the result
		c.JSON(http.StatusOK, result)
		return
	}

	// Direct service call if Temporal is not available
	product, err := h.productService.GetProduct(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to get product"})
		return
	}

	// Check if product exists
	if product.IsEmpty() {
		c.JSON(http.StatusNotFound, gin.H{"error": "Product not found"})
		return
	}

	c.JSON(http.StatusOK, product)
}

// ListProducts handles the request to list all products
func (h *ProductHandler) ListProducts(c *gin.Context) {
	// Direct service call (no Temporal workflow for listing)
	products, err := h.productService.ListProducts(c.Request.Context())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to list products"})
		return
	}

	c.JSON(http.StatusOK, products)
}

// UpdateProduct handles the request to update a product
func (h *ProductHandler) UpdateProduct(c *gin.Context) {
	// Get product ID from URL parameter
	idStr := c.Param("id")
	id, err := uuid.Parse(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid product ID"})
		return
	}

	// Parse request body
	var productRequest ProductRequest
	if err := c.ShouldBindJSON(&productRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Get existing product
	existingProduct, err := h.productService.GetProduct(c.Request.Context(), id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to get product"})
		return
	}

	// Check if product exists
	if existingProduct.IsEmpty() {
		c.JSON(http.StatusNotFound, gin.H{"error": "Product not found"})
		return
	}

	// Update product fields
	existingProduct.Name = productRequest.Name
	existingProduct.Description = productRequest.Description
	existingProduct.Price = productRequest.Price
	existingProduct.UpdatedAt = time.Now().UTC()

	// Try to update product using Temporal workflow if available
	if h.temporalClient != nil {
		result, err := h.temporalClient.UpdateProduct(c.Request.Context(), existingProduct)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to process request"})
			return
		}

		// Return the result
		c.JSON(http.StatusOK, result)
		return
	}

	// Direct service call if Temporal is not available
	err = h.productService.UpdateProduct(c.Request.Context(), existingProduct)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to update product"})
		return
	}

	c.JSON(http.StatusOK, existingProduct)
}

// DeleteProduct handles the request to delete a product
func (h *ProductHandler) DeleteProduct(c *gin.Context) {
	// Get product ID from URL parameter
	idStr := c.Param("id")
	id, err := uuid.Parse(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid product ID"})
		return
	}

	// Try to delete product using Temporal workflow if available
	if h.temporalClient != nil {
		success, err := h.temporalClient.DeleteProduct(c.Request.Context(), id)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to process request"})
			return
		}

		if !success {
			c.JSON(http.StatusNotFound, gin.H{"error": "Product not found"})
			return
		}

		// Return success
		c.JSON(http.StatusOK, gin.H{"message": "Product deleted successfully"})
		return
	}

	// Direct service call if Temporal is not available
	err = h.productService.DeleteProduct(c.Request.Context(), id)
	if err != nil {
		if err.Error() == "product not found" {
			c.JSON(http.StatusNotFound, gin.H{"error": "Product not found"})
			return
		}
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete product"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Product deleted successfully"})
}
```

### Step 8: Dapr Integration

Dapr (Distributed Application Runtime) provides building blocks for microservices. In the SaaSter Kit, we use Dapr for service-to-service communication, state management, and integration with external systems like Elasticsearch and Keycloak.

1. **Create Dapr Components**

Create a Dapr component for Keycloak authentication in `deployments/dapr/components/keycloak-auth.yaml`:

```yaml
apiVersion: dapr.io/v1alpha1
kind: Component
metadata:
  name: keycloak-auth
spec:
  type: middleware.http.oauth2
  version: v1
  metadata:
    - name: clientId
      value: product-manager
    - name: clientSecret
      secretKeyRef:
        name: keycloak-secret
        key: client-secret
    - name: scopes
      value: "openid profile email"
    - name: authURL
      value: "http://keycloak:8080/realms/saaster/protocol/openid-connect/auth"
    - name: tokenURL
      value: "http://keycloak:8080/realms/saaster/protocol/openid-connect/token"
    - name: introspectionURL
      value: "http://keycloak:8080/realms/saaster/protocol/openid-connect/token/introspect"
    - name: redirectURL
      value: "http://localhost:8080/callback"
```

Create a Dapr component for Elasticsearch logging in `deployments/dapr/components/elasticsearch-logs.yaml`:

```yaml
apiVersion: dapr.io/v1alpha1
kind: Component
metadata:
  name: elasticsearch-logs
spec:
  type: bindings.http
  version: v1
  metadata:
    - name: url
      value: "http://saaster-elasticsearch:9200/product-manager-logs/_doc"
    - name: method
      value: "POST"
```

2. **Create Dapr Configuration**

Create a Dapr configuration file in `deployments/dapr/config/config.yaml`:

```yaml
apiVersion: dapr.io/v1alpha1
kind: Configuration
metadata:
  name: product-manager-config
spec:
  tracing:
    samplingRate: "1"
    zipkin:
      endpointAddress: "http://zipkin:9411/api/v2/spans"
  metric:
    enabled: true
    rules:
      - name: "dapr_runtime_system_components_loaded"
        type: "counter"
        help: "The number of components loaded."
      - name: "dapr_runtime_api_received"
        type: "counter"
        help: "The number of API calls received."
  logging:
    apiLogging:
      enabled: true
    outputLevel: info
    appOutputLevel: info
    samplingRate: "1"
  mtls:
    enabled: true
  secrets:
    scopes:
      - storeName: kubernetes
        defaultAccess: allow
        allowedSecrets: ["keycloak-secret"]
```

3. **Create Elasticsearch Setup Script**

Create a script to set up the Elasticsearch index template in `scripts/setup-elasticsearch.sh`:

```bash
#!/bin/bash

# Wait for Elasticsearch to be ready
echo "Waiting for Elasticsearch to be ready..."
until curl -s "http://saaster-elasticsearch:9200/_cluster/health" | grep -q '"status":"green"'; do
  sleep 5
  echo "Still waiting for Elasticsearch..."
done

echo "Elasticsearch is ready. Creating index template..."

# Create index template for product-manager-logs
curl -X PUT "http://saaster-elasticsearch:9200/_template/product-manager-logs" -H 'Content-Type: application/json' -d'
{
  "index_patterns": ["product-manager-logs*"],
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "properties": {
      "level": { "type": "keyword" },
      "msg": { "type": "text" },
      "time": { "type": "date" },
      "service": { "type": "keyword" },
      "trace_id": { "type": "keyword" },
      "span_id": { "type": "keyword" },
      "fields": { "type": "object", "dynamic": true }
    }
  }
}'

# Create initial index
curl -X PUT "http://saaster-elasticsearch:9200/product-manager-logs-$(date +%Y.%m.%d)"

echo "Elasticsearch setup completed."
```

4. **Create Entrypoint Script**

Create an entrypoint script in `scripts/entrypoint.sh`:

```bash
#!/bin/bash
set -e

# Run the Elasticsearch setup script in the background
./scripts/setup-elasticsearch.sh &

# Start the main application
exec ./product_manager
```

5. **Update Dockerfile**

Update the Dockerfile to use the entrypoint script:

```dockerfile
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o product_manager ./cmd/main.go

# Use a small alpine image
FROM alpine:latest

# Install necessary packages
RUN apk --no-cache add ca-certificates tzdata curl bash

WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/product_manager .

# Copy migrations
COPY --from=builder /app/migrations ./migrations

# Copy scripts
COPY --from=builder /app/scripts ./scripts

# Make scripts executable
RUN chmod +x ./scripts/*.sh

# Expose port
EXPOSE 8080

# Run the application
CMD ["./scripts/entrypoint.sh"]
```

6. **Create Docker Compose Service**

Create a Docker Compose service configuration for your microservice (to be added to the main docker-compose.yml):

```yaml
  product_manager_db:
    image: postgres:${POSTGRESQL_VERSION}
    container_name: product_manager_db
    environment:
      POSTGRES_DB: product_manager_db
      POSTGRES_USER: product_manager
      POSTGRES_PASSWORD: password
    volumes:
      - product_manager_db_data:/var/lib/postgresql/data
    networks:
      - saaster-network
      - product-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U product_manager -d product_manager_db"]
      interval: 10s
      timeout: 5s
      retries: 5

  product_manager:
    build:
      context: ./backend/product_manager
      dockerfile: Dockerfile
    container_name: product_manager
    depends_on:
      product_manager_db:
        condition: service_healthy
      temporal:
        condition: service_healthy
    volumes:
      - ./backend/product_manager/scripts:/app/scripts
    environment:
      - SERVER_PORT=8080
      - DB_HOST=product_manager_db
      - DB_PORT=5432
      - DB_USER=product_manager
      - DB_PASSWORD=password
      - DB_NAME=product_manager_db
      - TEMPORAL_ADDRESS=temporal:7233
      - TEMPORAL_NAMESPACE=product-namespace
      - TEMPORAL_TASK_QUEUE=product-manager-task-queue
      - KEYCLOAK_URL=http://keycloak:8080
    networks:
      - saaster-network
      - product-network
    ports:
      - "8084:8080"

  product_manager_dapr:
    image: daprio/daprd:1.12.0
    container_name: product_manager_dapr
    depends_on:
      - product_manager
      - elasticsearch
    command: [
      "./daprd",
      "--app-id", "product-manager",
      "--app-port", "8080",
      "--dapr-http-port", "3500",
      "--dapr-grpc-port", "50001",
      "--components-path", "/components",
      "--config", "/config/config.yaml",
      "--log-level", "debug"
    ]
    volumes:
      - ./backend/product_manager/deployments/dapr/components:/components
      - ./backend/product_manager/deployments/dapr/config/config.yaml:/config/config.yaml
    network_mode: "service:product_manager"
```

Add the network and volume to the docker-compose.yml:

```yaml
networks:
  # ... other networks
  product-network:
    driver: bridge
    name: product-network

volumes:
  # ... other volumes
  product_manager_db_data:
```

### Step 9: Observability

Observability is crucial for monitoring and troubleshooting microservices. The SaaSter Kit includes a comprehensive observability stack with Elasticsearch for logs, Prometheus for metrics, and Grafana for visualization.

1. **Configure Prometheus Metrics**

Create a Prometheus configuration file in `deployments/prometheus/prometheus.yml` (or update the existing one):

```yaml
scrape_configs:
  # ... existing scrape configs
  - job_name: 'product-manager'
    scrape_interval: 15s
    metrics_path: /metrics
    static_configs:
      - targets: ['product_manager:8080']
```

2. **Configure Grafana Dashboard**

Create a Grafana dashboard configuration in `deployments/grafana/dashboards/product-manager.json`:

```json
{
  "annotations": {
    "list": [
      {
        "builtIn": 1,
        "datasource": "-- Grafana --",
        "enable": true,
        "hide": true,
        "iconColor": "rgba(0, 211, 255, 1)",
        "name": "Annotations & Alerts",
        "type": "dashboard"
      }
    ]
  },
  "editable": true,
  "gnetId": null,
  "graphTooltip": 0,
  "id": null,
  "links": [],
  "panels": [
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus",
      "fieldConfig": {
        "defaults": {
          "custom": {}
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 0,
        "y": 0
      },
      "hiddenSeries": false,
      "id": 2,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.3.7",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "rate(http_server_requests_seconds_count{job=\"product-manager\"}[5m])",
          "interval": "",
          "legendFormat": "{{method}} {{uri}} {{status}}",
          "refId": "A"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Request Rate",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    },
    {
      "aliasColors": {},
      "bars": false,
      "dashLength": 10,
      "dashes": false,
      "datasource": "Prometheus",
      "fieldConfig": {
        "defaults": {
          "custom": {}
        },
        "overrides": []
      },
      "fill": 1,
      "fillGradient": 0,
      "gridPos": {
        "h": 8,
        "w": 12,
        "x": 12,
        "y": 0
      },
      "hiddenSeries": false,
      "id": 3,
      "legend": {
        "avg": false,
        "current": false,
        "max": false,
        "min": false,
        "show": true,
        "total": false,
        "values": false
      },
      "lines": true,
      "linewidth": 1,
      "nullPointMode": "null",
      "options": {
        "alertThreshold": true
      },
      "percentage": false,
      "pluginVersion": "7.3.7",
      "pointradius": 2,
      "points": false,
      "renderer": "flot",
      "seriesOverrides": [],
      "spaceLength": 10,
      "stack": false,
      "steppedLine": false,
      "targets": [
        {
          "expr": "rate(http_server_requests_seconds_sum{job=\"product-manager\"}[5m]) / rate(http_server_requests_seconds_count{job=\"product-manager\"}[5m])",
          "interval": "",
          "legendFormat": "{{method}} {{uri}} {{status}}",
          "refId": "A"
        }
      ],
      "thresholds": [],
      "timeFrom": null,
      "timeRegions": [],
      "timeShift": null,
      "title": "Response Time",
      "tooltip": {
        "shared": true,
        "sort": 0,
        "value_type": "individual"
      },
      "type": "graph",
      "xaxis": {
        "buckets": null,
        "mode": "time",
        "name": null,
        "show": true,
        "values": []
      },
      "yaxes": [
        {
          "format": "s",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        },
        {
          "format": "short",
          "label": null,
          "logBase": 1,
          "max": null,
          "min": null,
          "show": true
        }
      ],
      "yaxis": {
        "align": false,
        "alignLevel": null
      }
    }
  ],
  "refresh": "10s",
  "schemaVersion": 26,
  "style": "dark",
  "tags": [],
  "templating": {
    "list": []
  },
  "time": {
    "from": "now-1h",
    "to": "now"
  },
  "timepicker": {},
  "timezone": "",
  "title": "Product Manager Dashboard",
  "uid": "product-manager",
  "version": 1
}
```

3. **Configure Elasticsearch Index Pattern**

Create an Elasticsearch index pattern configuration in `deployments/grafana/provisioning/datasources/elasticsearch.yml`:

```yaml
apiVersion: 1

datasources:
  - name: Elasticsearch
    type: elasticsearch
    access: proxy
    url: http://saaster-elasticsearch:9200
    database: "product-manager-logs-*"
    isDefault: false
    jsonData:
      timeField: "time"
      esVersion: 7
      logMessageField: "msg"
      logLevelField: "level"
```

4. **Add Metrics to the Application**

Update the main.go file to include Prometheus metrics:

```go
package main

import (
	// ... existing imports
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

// Define metrics
var (
	httpRequestsTotal = prometheus.NewCounterVec(
		prometheus.CounterOpts{
			Name: "http_requests_total",
			Help: "Total number of HTTP requests",
		},
		[]string{"method", "endpoint", "status"},
	)

	httpRequestDuration = prometheus.NewHistogramVec(
		prometheus.HistogramOpts{
			Name:    "http_request_duration_seconds",
			Help:    "HTTP request duration in seconds",
			Buckets: prometheus.DefBuckets,
		},
		[]string{"method", "endpoint", "status"},
	)
)

func init() {
	// Register metrics with Prometheus
	prometheus.MustRegister(httpRequestsTotal)
	prometheus.MustRegister(httpRequestDuration)
}

func main() {
	// ... existing code

	// Add metrics middleware
	router.Use(func(c *gin.Context) {
		start := time.Now()
		path := c.Request.URL.Path
		method := c.Request.Method

		c.Next()

		status := fmt.Sprintf("%d", c.Writer.Status())
		latency := time.Since(start)

		// Record metrics
		httpRequestsTotal.WithLabelValues(method, path, status).Inc()
		httpRequestDuration.WithLabelValues(method, path, status).Observe(latency.Seconds())

		// ... existing logging code
	})

	// Add Prometheus metrics endpoint
	router.GET("/metrics", gin.WrapH(promhttp.Handler()))

	// ... rest of the code
}
```

5. **Update go.mod with Prometheus Dependencies**

Add Prometheus dependencies to your go.mod file:

```
go get github.com/prometheus/client_golang/prometheus
go get github.com/prometheus/client_golang/prometheus/promhttp
```

### Step 10: Testing

Testing is a critical part of microservice development. The SaaSter Kit uses Behavior-Driven Development (BDD) with Gherkin and Godog for acceptance testing, along with standard Go unit tests.

1. **Create Gherkin Feature Files**

Create a feature file in `tests/features/product.feature`:

```gherkin
Feature: Product Management
  As a system administrator
  I want to manage products
  So that I can keep track of all products in the system

  Scenario: Add a new product
    Given I am authenticated as an administrator
    When I add a new product with the following details:
      | Name        | Description           | Price |
      | Test Product| A test product        | 99.99 |
    Then the product should be successfully added to the system
    And I should receive a confirmation with the product's UUID

  Scenario: Retrieve a product
    Given I am authenticated as an administrator
    And there is a product with UUID "00000000-0000-0000-0000-000000000001" in the system
    When I request the product with UUID "00000000-0000-0000-0000-000000000001"
    Then I should receive the product details

  Scenario: Update a product
    Given I am authenticated as an administrator
    And there is a product with UUID "00000000-0000-0000-0000-000000000001" in the system
    When I update the product with the following details:
      | Name        | Description           | Price |
      | Updated Product| An updated product | 149.99|
    Then the product should be successfully updated

  Scenario: Delete a product
    Given I am authenticated as an administrator
    And there is a product with UUID "00000000-0000-0000-0000-000000000001" in the system
    When I delete the product with UUID "00000000-0000-0000-0000-000000000001"
    Then the product should be successfully deleted from the system
```

2. **Implement Step Definitions**

Create step definitions in `tests/steps/product_steps.go`:

```go
package steps

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"os"
	"testing"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/adapters/handlers"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/adapters/repositories"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/application/services"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/cucumber/godog"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

type productTest struct {
	router       *gin.Engine
	response     *httptest.ResponseRecorder
	productRepo  *repositories.MockProductRepository
	productUUID  uuid.UUID
	authToken    string
	requestBody  map[string]interface{}
	responseBody map[string]interface{}
}

func NewProductTest() *productTest {
	// Set Gin to test mode
	gin.SetMode(gin.TestMode)

	// Create a mock repository
	mockRepo := repositories.NewMockProductRepository()

	// Create a service with the mock repository
	productService := services.NewProductService(mockRepo)

	// Create a handler with the service
	productHandler := handlers.NewProductHandler(productService, nil)

	// Create a router
	router := gin.New()
	router.Use(gin.Recovery())

	// Define routes
	api := router.Group("/api/v1")
	{
		protected := api.Group("/products")
		protected.Use(func(c *gin.Context) {
			// Mock authentication middleware
			c.Set("userID", "test-user-id")
			c.Next()
		})
		{
			protected.POST("", productHandler.AddProduct)
			protected.GET("", productHandler.ListProducts)
			protected.GET("/:id", productHandler.GetProduct)
			protected.PUT("/:id", productHandler.UpdateProduct)
			protected.DELETE("/:id", productHandler.DeleteProduct)
		}
	}

	return &productTest{
		router:      router,
		productRepo: mockRepo,
		authToken:   "Bearer test-token",
	}
}

func (p *productTest) reset() {
	p.response = httptest.NewRecorder()
	p.requestBody = make(map[string]interface{})
	p.responseBody = make(map[string]interface{})
	p.productUUID = uuid.Nil
}

// Step definitions

func (p *productTest) iAmAuthenticatedAsAnAdministrator() error {
	// Authentication is mocked in the router setup
	return nil
}

func (p *productTest) iAddANewProductWithTheFollowingDetails(table *godog.Table) error {
	// Parse the table
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least one data row")
	}

	// Get column names from the header row
	columns := make([]string, len(table.Rows[0].Cells))
	for i, cell := range table.Rows[0].Cells {
		columns[i] = cell.Value
	}

	// Get data from the first data row
	data := make(map[string]string)
	for i, cell := range table.Rows[1].Cells {
		data[columns[i]] = cell.Value
	}

	// Create request body
	p.requestBody["name"] = data["Name"]
	p.requestBody["description"] = data["Description"]
	p.requestBody["price"], _ = strconv.ParseFloat(data["Price"], 64)

	// Convert request body to JSON
	jsonData, err := json.Marshal(p.requestBody)
	if err != nil {
		return err
	}

	// Create request
	req, err := http.NewRequest("POST", "/api/v1/products", bytes.NewBuffer(jsonData))
	if err != nil {
		return err
	}
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", p.authToken)

	// Perform request
	p.router.ServeHTTP(p.response, req)

	// Parse response
	if p.response.Code != http.StatusOK {
		return fmt.Errorf("expected status code %d but got %d", http.StatusOK, p.response.Code)
	}

	err = json.Unmarshal(p.response.Body.Bytes(), &p.responseBody)
	if err != nil {
		return err
	}

	// Extract product UUID
	uuidStr, ok := p.responseBody["uuid"].(string)
	if !ok {
		return fmt.Errorf("response does not contain a UUID")
	}

	p.productUUID, err = uuid.Parse(uuidStr)
	if err != nil {
		return err
	}

	return nil
}

func (p *productTest) theProductShouldBeSuccessfullyAddedToTheSystem() error {
	// Check if the product exists in the repository
	product, err := p.productRepo.FindByID(context.Background(), p.productUUID)
	if err != nil {
		return err
	}

	if product.IsEmpty() {
		return fmt.Errorf("product was not added to the system")
	}

	return nil
}

func (p *productTest) iShouldReceiveAConfirmationWithTheProductsUUID() error {
	// Check if the response contains a UUID
	uuidStr, ok := p.responseBody["uuid"].(string)
	if !ok {
		return fmt.Errorf("response does not contain a UUID")
	}

	// Check if the UUID is valid
	_, err := uuid.Parse(uuidStr)
	if err != nil {
		return fmt.Errorf("invalid UUID in response: %s", uuidStr)
	}

	return nil
}

func (p *productTest) thereIsAProductWithUUIDInTheSystem(uuidStr string) error {
	// Parse UUID
	id, err := uuid.Parse(uuidStr)
	if err != nil {
		return err
	}

	// Create a test product
	product := entities.NewProduct(
		id,
		"Test Product",
		"A test product",
		99.99,
	)

	// Add the product to the repository
	err = p.productRepo.Save(context.Background(), product)
	if err != nil {
		return err
	}

	p.productUUID = id
	return nil
}

func (p *productTest) iRequestTheProductWithUUID(uuidStr string) error {
	// Parse UUID
	id, err := uuid.Parse(uuidStr)
	if err != nil {
		return err
	}

	// Create request
	req, err := http.NewRequest("GET", fmt.Sprintf("/api/v1/products/%s", id), nil)
	if err != nil {
		return err
	}
	req.Header.Set("Authorization", p.authToken)

	// Perform request
	p.router.ServeHTTP(p.response, req)

	// Parse response
	if p.response.Code != http.StatusOK {
		return fmt.Errorf("expected status code %d but got %d", http.StatusOK, p.response.Code)
	}

	err = json.Unmarshal(p.response.Body.Bytes(), &p.responseBody)
	if err != nil {
		return err
	}

	return nil
}

func (p *productTest) iShouldReceiveTheProductDetails() error {
	// Check if the response contains the product details
	uuidStr, ok := p.responseBody["uuid"].(string)
	if !ok {
		return fmt.Errorf("response does not contain a UUID")
	}

	// Check if the UUID matches
	if uuidStr != p.productUUID.String() {
		return fmt.Errorf("expected UUID %s but got %s", p.productUUID, uuidStr)
	}

	// Check other fields
	name, ok := p.responseBody["name"].(string)
	if !ok || name != "Test Product" {
		return fmt.Errorf("response does not contain the correct name")
	}

	description, ok := p.responseBody["description"].(string)
	if !ok || description != "A test product" {
		return fmt.Errorf("response does not contain the correct description")
	}

	price, ok := p.responseBody["price"].(float64)
	if !ok || price != 99.99 {
		return fmt.Errorf("response does not contain the correct price")
	}

	return nil
}

// Additional step definitions for update and delete scenarios would be implemented here

// InitializeScenario initializes the test suite
func InitializeScenario(ctx *godog.ScenarioContext) {
	test := NewProductTest()

	// Before each scenario
	ctx.Before(func(ctx context.Context, sc *godog.Scenario) (context.Context, error) {
		test.reset()
		return ctx, nil
	})

	// Register step definitions
	ctx.Step(`^I am authenticated as an administrator$`, test.iAmAuthenticatedAsAnAdministrator)
	ctx.Step(`^I add a new product with the following details:$`, test.iAddANewProductWithTheFollowingDetails)
	ctx.Step(`^the product should be successfully added to the system$`, test.theProductShouldBeSuccessfullyAddedToTheSystem)
	ctx.Step(`^I should receive a confirmation with the product's UUID$`, test.iShouldReceiveAConfirmationWithTheProductsUUID)
	ctx.Step(`^there is a product with UUID "([^"]*)" in the system$`, test.thereIsAProductWithUUIDInTheSystem)
	ctx.Step(`^I request the product with UUID "([^"]*)"$`, test.iRequestTheProductWithUUID)
	ctx.Step(`^I should receive the product details$`, test.iShouldReceiveTheProductDetails)

	// Additional steps for update and delete scenarios would be registered here
}
```

3. **Create Mock Repository**

Create a mock repository for testing in `internal/adapters/repositories/mock_product_repository.go`:

```go
package repositories

import (
	"context"
	"sync"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/google/uuid"
)

// MockProductRepository is a mock implementation of the ProductRepository interface
type MockProductRepository struct {
	products map[uuid.UUID]*entities.Product
	mutex    sync.RWMutex
}

// NewMockProductRepository creates a new mock product repository
func NewMockProductRepository() *MockProductRepository {
	return &MockProductRepository{
		products: make(map[uuid.UUID]*entities.Product),
	}
}

// Save saves a product to the mock repository
func (r *MockProductRepository) Save(ctx context.Context, product *entities.Product) error {
	r.mutex.Lock()
	defer r.mutex.Unlock()

	// Create a copy of the product
	copy := *product
	r.products[product.UUID] = &copy

	return nil
}

// FindByID finds a product by UUID in the mock repository
func (r *MockProductRepository) FindByID(ctx context.Context, id uuid.UUID) (*entities.Product, error) {
	r.mutex.RLock()
	defer r.mutex.RUnlock()

	product, ok := r.products[id]
	if !ok {
		return &entities.Product{}, nil
	}

	// Create a copy of the product
	copy := *product
	return &copy, nil
}

// Update updates an existing product in the mock repository
func (r *MockProductRepository) Update(ctx context.Context, product *entities.Product) error {
	r.mutex.Lock()
	defer r.mutex.Unlock()

	// Check if the product exists
	_, ok := r.products[product.UUID]
	if !ok {
		return fmt.Errorf("product not found")
	}

	// Create a copy of the product
	copy := *product
	r.products[product.UUID] = &copy

	return nil
}

// Delete deletes a product by UUID from the mock repository
func (r *MockProductRepository) Delete(ctx context.Context, id uuid.UUID) error {
	r.mutex.Lock()
	defer r.mutex.Unlock()

	// Check if the product exists
	_, ok := r.products[id]
	if !ok {
		return fmt.Errorf("product not found")
	}

	// Delete the product
	delete(r.products, id)

	return nil
}

// FindAll returns all products from the mock repository
func (r *MockProductRepository) FindAll(ctx context.Context) ([]*entities.Product, error) {
	r.mutex.RLock()
	defer r.mutex.RUnlock()

	// Create a slice of products
	products := make([]*entities.Product, 0, len(r.products))

	// Add all products to the slice
	for _, product := range r.products {
		// Create a copy of the product
		copy := *product
		products = append(products, &copy)
	}

	return products, nil
}
```

4. **Create Test Runner**

Create a test runner in `tests/product_test.go`:

```go
package tests

import (
	"testing"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/tests/steps"
	"github.com/cucumber/godog"
)

func TestFeatures(t *testing.T) {
	suite := godog.TestSuite{
		ScenarioInitializer: steps.InitializeScenario,
		Options: &godog.Options{
			Format:   "pretty",
			Paths:    []string{"features"},
			TestingT: t,
		},
	}

	if suite.Run() != 0 {
		t.Fatal("non-zero status returned, failed to run feature tests")
	}
}
```

5. **Create Unit Tests**

Create unit tests for the service layer in `internal/application/services/product_service_test.go`:

```go
package services_test

import (
	"context"
	"testing"

	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/adapters/repositories"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/application/services"
	"github.com/b-fontaine/saaster_kit/backend/product_manager/internal/domain/entities"
	"github.com/google/uuid"
	"github.com/stretchr/testify/assert"
)

func TestAddProduct(t *testing.T) {
	// Create a mock repository
	repo := repositories.NewMockProductRepository()

	// Create a service with the mock repository
	service := services.NewProductService(repo)

	// Create a test product
	id := uuid.New()
	product := entities.NewProduct(
		id,
		"Test Product",
		"A test product",
		99.99,
	)

	// Add the product
	err := service.AddProduct(context.Background(), product)

	// Check that there was no error
	assert.NoError(t, err)

	// Check that the product was added
	savedProduct, err := service.GetProduct(context.Background(), id)
	assert.NoError(t, err)
	assert.Equal(t, product.UUID, savedProduct.UUID)
	assert.Equal(t, product.Name, savedProduct.Name)
	assert.Equal(t, product.Description, savedProduct.Description)
	assert.Equal(t, product.Price, savedProduct.Price)
}

func TestGetProduct(t *testing.T) {
	// Create a mock repository
	repo := repositories.NewMockProductRepository()

	// Create a service with the mock repository
	service := services.NewProductService(repo)

	// Create a test product
	id := uuid.New()
	product := entities.NewProduct(
		id,
		"Test Product",
		"A test product",
		99.99,
	)

	// Add the product to the repository
	err := repo.Save(context.Background(), product)
	assert.NoError(t, err)

	// Get the product
	savedProduct, err := service.GetProduct(context.Background(), id)

	// Check that there was no error
	assert.NoError(t, err)

	// Check that the product was retrieved correctly
	assert.Equal(t, product.UUID, savedProduct.UUID)
	assert.Equal(t, product.Name, savedProduct.Name)
	assert.Equal(t, product.Description, savedProduct.Description)
	assert.Equal(t, product.Price, savedProduct.Price)
}

// Additional tests for UpdateProduct, DeleteProduct, and ListProducts would be implemented here
```

6. **Update Makefile with Test Commands**

Update the Makefile with test commands:

```makefile
.PHONY: build test test-unit test-integration run clean docker-build

# Build variables
BINARY_NAME=product_manager
MAIN_FILE=cmd/main.go

# Docker variables
DOCKER_IMAGE=product_manager:latest

# Build the application
build:
	go build -o $(BINARY_NAME) $(MAIN_FILE)

# Run the application
run: build
	./$(BINARY_NAME)

# Run unit tests
test-unit:
	go test -v ./internal/...

# Run integration tests
test-integration:
	cd tests && go test -v

# Run all tests
test: test-unit test-integration

# Clean build artifacts
clean:
	rm -f $(BINARY_NAME)
	go clean

# Build Docker image
docker-build:
	docker build -t $(DOCKER_IMAGE) .

# Run migrations
migrate-up:
	go run -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate \
		-path ./migrations \
		-database "postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=disable" \
		up
```

### Step 11: Docker Configuration

Docker is used to containerize the microservice and its dependencies. This ensures consistent deployment across different environments.

1. **Create a Dockerfile**

Create a Dockerfile in the root of your microservice directory:

```dockerfile
# Build stage
FROM golang:1.22-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache git

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o product_manager ./cmd/main.go

# Final stage
FROM alpine:latest

# Install necessary packages
RUN apk --no-cache add ca-certificates tzdata curl bash

WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/product_manager .

# Copy migrations
COPY --from=builder /app/migrations ./migrations

# Copy scripts
COPY --from=builder /app/scripts ./scripts

# Make scripts executable
RUN chmod +x ./scripts/*.sh

# Create a non-root user to run the application
RUN adduser -D -g '' appuser
RUN chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 8080

# Run the application
CMD ["./scripts/entrypoint.sh"]
```

2. **Create a .dockerignore File**

Create a .dockerignore file to exclude unnecessary files from the Docker build context:

```
# Git
.git
.gitignore

# Docker
Dockerfile
.dockerignore

# IDE files
.idea/
.vscode/
*.swp
*.swo

# Build artifacts
bin/
tmp/

# Dependency directories
vendor/

# Test files
*_test.go
tests/

# Misc
README.md
LICENSE
```

3. **Create Database Migrations**

Create database migrations in the `migrations` directory:

```sql
-- migrations/000001_create_products_table.up.sql
CREATE TABLE IF NOT EXISTS products (
    uuid UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL
);

-- migrations/000001_create_products_table.down.sql
DROP TABLE IF EXISTS products;
```

4. **Create Docker Compose Configuration**

Create a Docker Compose configuration for local development in `docker-compose.local.yml`:

```yaml
version: '3.8'

services:
  product_manager_db:
    image: postgres:15-alpine
    container_name: product_manager_db_local
    environment:
      POSTGRES_DB: product_manager_db
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
    ports:
      - "5432:5432"
    volumes:
      - product_manager_db_data:/var/lib/postgresql/data
    networks:
      - product-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres -d product_manager_db"]
      interval: 10s
      timeout: 5s
      retries: 5

  product_manager:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: product_manager_local
    depends_on:
      product_manager_db:
        condition: service_healthy
    ports:
      - "8080:8080"
    environment:
      - SERVER_PORT=8080
      - DB_HOST=product_manager_db
      - DB_PORT=5432
      - DB_USER=postgres
      - DB_PASSWORD=password
      - DB_NAME=product_manager_db
    networks:
      - product-network
    volumes:
      - ./scripts:/app/scripts

networks:
  product-network:
    driver: bridge

volumes:
  product_manager_db_data:
```

5. **Create Scripts for Docker**

Create a script for database initialization in `scripts/init-db.sh`:

```bash
#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE product_manager_db;
    GRANT ALL PRIVILEGES ON DATABASE product_manager_db TO postgres;

    \c product_manager_db

    CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
EOSQL
```

Create an entrypoint script in `scripts/entrypoint.sh`:

```bash
#!/bin/bash
set -e

# Wait for the database to be ready
echo "Waiting for database to be ready..."
until nc -z $DB_HOST $DB_PORT; do
  sleep 1
done
echo "Database is ready!"

# Run migrations
echo "Running migrations..."
go run -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate \
  -path ./migrations \
  -database "postgres://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME?sslmode=disable" \
  up
echo "Migrations completed!"

# Run the Elasticsearch setup script in the background (if it exists)
if [ -f "./scripts/setup-elasticsearch.sh" ]; then
  echo "Setting up Elasticsearch..."
  ./scripts/setup-elasticsearch.sh &
fi

# Start the application
echo "Starting the application..."
exec ./product_manager
```

6. **Create a .env File**

Create a .env file for environment variables:

```
# Server
SERVER_PORT=8080

# Database
DB_HOST=product_manager_db
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=password
DB_NAME=product_manager_db

# Temporal
TEMPORAL_ADDRESS=temporal:7233
TEMPORAL_NAMESPACE=product-namespace
TEMPORAL_TASK_QUEUE=product-manager-task-queue

# Keycloak
KEYCLOAK_URL=http://keycloak:8080
```

7. **Create a Makefile for Docker Commands**

Update the Makefile with Docker commands:

```makefile
# Docker commands
docker-build:
	docker build -t $(DOCKER_IMAGE) .

docker-run:
	docker run -p 8080:8080 --env-file .env $(DOCKER_IMAGE)

docker-compose-up:
	docker-compose -f docker-compose.local.yml up -d

docker-compose-down:
	docker-compose -f docker-compose.local.yml down

docker-compose-logs:
	docker-compose -f docker-compose.local.yml logs -f

docker-compose-build:
	docker-compose -f docker-compose.local.yml build

docker-compose-restart:
	docker-compose -f docker-compose.local.yml restart
```

### Step 12: Docker Compose Integration

The final step is to integrate your microservice into the main SaaSter Kit Docker Compose configuration. This allows your microservice to work with the other components of the system.

1. **Update the Main Docker Compose File**

Add your microservice configuration to the main `docker-compose.yml` file in the root of the SaaSter Kit project:

```yaml
  # Product Manager Database
  product_manager_db:
    image: postgres:${POSTGRESQL_VERSION}
    container_name: product_manager_db
    environment:
      POSTGRES_DB: product_manager_db
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: password
    volumes:
      - product_manager_db_data:/var/lib/postgresql/data
    networks:
      - saaster-network
      - product-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres -d product_manager_db"]
      interval: 10s
      timeout: 5s
      retries: 5

  # Product Manager Service
  product_manager:
    build:
      context: ./backend/product_manager
      dockerfile: Dockerfile
    container_name: product_manager
    depends_on:
      product_manager_db:
        condition: service_healthy
      temporal:
        condition: service_healthy
      elasticsearch:
        condition: service_healthy
    environment:
      - SERVER_PORT=8080
      - DB_HOST=product_manager_db
      - DB_PORT=5432
      - DB_USER=postgres
      - DB_PASSWORD=password
      - DB_NAME=product_manager_db
      - TEMPORAL_ADDRESS=temporal:7233
      - TEMPORAL_NAMESPACE=product-namespace
      - TEMPORAL_TASK_QUEUE=product-manager-task-queue
      - KEYCLOAK_URL=http://keycloak:8080
    networks:
      - saaster-network
      - product-network
    ports:
      - "8084:8080"

  # Product Manager Dapr Sidecar
  product_manager_dapr:
    image: daprio/daprd:${DAPR_VERSION}
    container_name: product_manager_dapr
    depends_on:
      - product_manager
      - elasticsearch
    command: [
      "./daprd",
      "--app-id", "product-manager",
      "--app-port", "8080",
      "--dapr-http-port", "3500",
      "--dapr-grpc-port", "50001",
      "--components-path", "/components",
      "--config", "/config/config.yaml",
      "--log-level", "debug"
    ]
    volumes:
      - ./backend/product_manager/deployments/dapr/components:/components
      - ./backend/product_manager/deployments/dapr/config/config.yaml:/config/config.yaml
    network_mode: "service:product_manager"
```

Add the network and volume to the main Docker Compose file:

```yaml
networks:
  # ... other networks
  product-network:
    driver: bridge

volumes:
  # ... other volumes
  product_manager_db_data:
```

2. **Update API Gateway Configuration**

Update the Kong API gateway configuration to route requests to your microservice:

```yaml
  # Kong API Gateway Configuration
  kong-migrations:
    # ... existing configuration
    environment:
      # ... existing environment variables
      KONG_DECLARATIVE_CONFIG: /kong/declarative/kong.yml
    volumes:
      # ... existing volumes
      - ./gateway/kong/kong.yml:/kong/declarative/kong.yml
```

Create or update the Kong configuration file in `gateway/kong/kong.yml`:

```yaml
_format_version: "2.1"

services:
  # ... existing services

  # Product Manager Service
  - name: product-manager-service
    url: http://product_manager:8080
    routes:
      - name: product-manager-route
        paths:
          - /api/v1/products
        strip_path: false
    plugins:
      - name: key-auth
      - name: cors
        config:
          origins:
            - "*"
          methods:
            - GET
            - POST
            - PUT
            - DELETE
            - OPTIONS
          headers:
            - Content-Type
            - Authorization
          credentials: true
          preflight_continue: false
          max_age: 3600
```

3. **Update Prometheus Configuration**

Update the Prometheus configuration to scrape metrics from your microservice:

```yaml
scrape_configs:
  # ... existing scrape configs
  - job_name: 'product-manager'
    scrape_interval: 15s
    metrics_path: /metrics
    static_configs:
      - targets: ['product_manager:8080']
```

4. **Update Grafana Dashboard Provisioning**

Update the Grafana dashboard provisioning to include your microservice dashboard:

```yaml
apiVersion: 1

providers:
  # ... existing providers
  - name: 'product-manager'
    orgId: 1
    folder: 'Product Manager'
    type: file
    disableDeletion: false
    editable: true
    options:
      path: /etc/grafana/provisioning/dashboards/product-manager
```

5. **Test the Integration**

Start the entire SaaSter Kit with your new microservice:

```bash
docker compose -p saaster up -d --build
```

Verify that your microservice is running correctly:

```bash
docker compose -p saaster ps
```

Check the logs of your microservice:

```bash
docker compose -p saaster logs -f product_manager
```

Test the API endpoints through the Kong API gateway:

```bash
curl -X GET http://localhost:8000/api/v1/products -H "Authorization: Bearer <token>"
```

Verify that metrics are being collected in Prometheus and visualized in Grafana.

Verify that logs are being sent to Elasticsearch and can be viewed in Grafana.

6. **Document Your Microservice**

Create a README.md file in your microservice directory to document its functionality, API endpoints, and configuration options.

Update the main SaaSter Kit documentation to include information about your new microservice.

## Creating a New Microservice with Augment Code

Augment Code provides a powerful way to create new microservices with a single prompt. This section demonstrates how to use Augment Code to create a complete microservice following the SaaSter Kit architecture.

### Example Prompt for Creating a New Microservice

Here's an example prompt that you can use with Augment Code to create a new microservice:

```
Create a new microservice called "inventory_manager" for the SaaSter Kit backend with the following specifications:

1. Domain entities:
   - Item: with fields for UUID, name, SKU, quantity, location, and timestamps
   - Location: with fields for UUID, name, address, and timestamps

2. Core functionality:
   - Add, get, update, and delete items
   - Add, get, update, and delete locations
   - Transfer items between locations
   - Generate inventory reports

3. API endpoints:
   - RESTful endpoints for all CRUD operations on items and locations
   - Endpoint for transferring items between locations
   - Endpoint for generating inventory reports

4. Database:
   - PostgreSQL with appropriate migrations
   - Separate tables for items and locations with proper relationships

5. Integration:
   - Temporal workflows for long-running operations
   - Dapr for service-to-service communication
   - Elasticsearch for logging
   - Prometheus for metrics
   - Keycloak for authentication

6. Testing:
   - BDD tests with Gherkin and Godog
   - Unit tests for core functionality

Follow the hexagonal architecture pattern with domain, ports, adapters, and application layers. Implement CQRS for separating read and write operations. Ensure proper error handling, validation, and logging throughout the service.
```

### What Augment Code Will Generate

With this prompt, Augment Code will generate a complete microservice with:

1. **Project Structure**: All necessary directories and files following the hexagonal architecture pattern

2. **Domain Layer**: Entity definitions for Item and Location with appropriate methods

3. **Ports Layer**: Interface definitions for service and repository operations

4. **Adapters Layer**: Implementations for repositories, HTTP handlers, Temporal workflows, and logging

5. **Application Layer**: Service implementations orchestrating the business logic

6. **Infrastructure**: Database migrations, Dockerfile, Makefile, and configuration files

7. **Testing**: BDD feature files and step definitions for testing the service

8. **Documentation**: README.md with service documentation and usage examples

### Best Practices for Augment Code Prompts

To get the best results from Augment Code when creating microservices:

1. **Be Specific**: Clearly define the domain entities, operations, and integrations you need

2. **Mention Architecture**: Explicitly request hexagonal architecture and CQRS if desired

3. **Specify Technologies**: List the technologies you want to use (Temporal, Dapr, etc.)

4. **Include Testing Requirements**: Mention the testing approach (BDD, unit tests, etc.)

5. **Request Documentation**: Ask for comprehensive documentation of the service

6. **Provide Examples**: If you have specific patterns or conventions, include examples

7. **Iterate**: Start with a basic prompt and then ask for specific enhancements

### Post-Generation Steps

After Augment Code generates the microservice:

1. Review the generated code for correctness and completeness

2. Add the service to the docker-compose.yml file

3. Update any shared configurations or dependencies

4. Run tests to ensure everything works as expected

5. Deploy the service as part of the SaaSter Kit
