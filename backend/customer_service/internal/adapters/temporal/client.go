package temporal

import (
	"context"
	"fmt"
	"google.golang.org/protobuf/types/known/durationpb"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/domain/entities"
	"github.com/google/uuid"
	"go.temporal.io/api/workflowservice/v1"
	"go.temporal.io/sdk/client"
	"go.temporal.io/sdk/temporal"
)

// TemporalClient is a wrapper for the Temporal client
type TemporalClient struct {
	Client    client.Client
	namespace string
	taskQueue string
}

// NewTemporalClient creates a new Temporal client
func NewTemporalClient(address, namespace, taskQueue string) (*TemporalClient, error) {
	c, err := client.Dial(client.Options{
		HostPort:  address,
		Namespace: namespace,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to create Temporal client: %w", err)
	}

	// Ensure namespace exists
	if err := ensureNamespaceExists(c, namespace); err != nil {
		c.Close()
		return nil, fmt.Errorf("failed to ensure namespace exists: %w", err)
	}

	return &TemporalClient{
		Client:    c,
		namespace: namespace,
		taskQueue: taskQueue,
	}, nil
}

// ensureNamespaceExists ensures that the specified namespace exists
func ensureNamespaceExists(c client.Client, namespace string) error {
	// Get the gRPC client
	clientService := c.WorkflowService()

	// Check if namespace exists
	_, err := clientService.DescribeNamespace(context.Background(), &workflowservice.DescribeNamespaceRequest{
		Namespace: namespace,
	})

	if err == nil {
		// Namespace exists
		return nil
	}

	// Create namespace if it doesn't exist
	_, err = clientService.RegisterNamespace(context.Background(), &workflowservice.RegisterNamespaceRequest{
		Namespace: namespace,
		WorkflowExecutionRetentionPeriod: &durationpb.Duration{
			Seconds: int64(time.Duration(7*24) * time.Hour),
		},
	})

	if err != nil {
		return fmt.Errorf("failed to register namespace: %w", err)
	}

	return nil
}

// Close closes the Temporal client
func (c *TemporalClient) Close() {
	if c.Client != nil {
		c.Client.Close()
	}
}

// IsConnected returns true if the client is connected
func (c *TemporalClient) IsConnected() bool {
	return c.Client != nil
}

// AddCustomer starts the AddCustomer workflow
func (c *TemporalClient) AddCustomer(ctx context.Context, customerEntity *entities.Customer) (*entities.Customer, error) {
	workflowID := fmt.Sprintf("add-customer-%s", customerEntity.UUID.String())
	workflowOptions := client.StartWorkflowOptions{
		ID:        workflowID,
		TaskQueue: c.taskQueue,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}

	// Start workflow
	run, err := c.Client.ExecuteWorkflow(ctx, workflowOptions, "AddCustomerWorkflow", customerEntity)
	if err != nil {
		return nil, fmt.Errorf("failed to start AddCustomer workflow: %w", err)
	}

	// Wait for workflow completion
	var result entities.Customer
	if err := run.Get(ctx, &result); err != nil {
		return nil, fmt.Errorf("workflow execution failed: %w", err)
	}

	return &result, nil
}

// GetCustomer starts the GetCustomer workflow
func (c *TemporalClient) GetCustomer(ctx context.Context, id uuid.UUID) (*entities.Customer, error) {
	workflowID := fmt.Sprintf("get-customer-%s", id.String())
	workflowOptions := client.StartWorkflowOptions{
		ID:        workflowID,
		TaskQueue: c.taskQueue,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}

	// Start workflow
	run, err := c.Client.ExecuteWorkflow(ctx, workflowOptions, "GetCustomerWorkflow", id)
	if err != nil {
		return nil, fmt.Errorf("failed to start GetCustomer workflow: %w", err)
	}

	// Wait for workflow completion
	var result entities.Customer
	if err := run.Get(ctx, &result); err != nil {
		return nil, fmt.Errorf("workflow execution failed: %w", err)
	}

	return &result, nil
}

// UpdateCustomer starts the UpdateCustomer workflow
func (c *TemporalClient) UpdateCustomer(ctx context.Context, customerEntity *entities.Customer) (*entities.Customer, error) {
	workflowID := fmt.Sprintf("update-customer-%s", customerEntity.UUID.String())
	workflowOptions := client.StartWorkflowOptions{
		ID:        workflowID,
		TaskQueue: c.taskQueue,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}

	// Start workflow
	run, err := c.Client.ExecuteWorkflow(ctx, workflowOptions, "UpdateCustomerWorkflow", customerEntity)
	if err != nil {
		return nil, fmt.Errorf("failed to start UpdateCustomer workflow: %w", err)
	}

	// Wait for workflow completion
	var result entities.Customer
	if err := run.Get(ctx, &result); err != nil {
		return nil, fmt.Errorf("workflow execution failed: %w", err)
	}

	return &result, nil
}

// ListCustomers starts the ListCustomers workflow
func (c *TemporalClient) ListCustomers(ctx context.Context) ([]*entities.Customer, error) {
	workflowID := fmt.Sprintf("list-customers-%s", uuid.New().String())
	workflowOptions := client.StartWorkflowOptions{
		ID:        workflowID,
		TaskQueue: c.taskQueue,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}

	// Start workflow
	run, err := c.Client.ExecuteWorkflow(ctx, workflowOptions, "ListCustomersWorkflow")
	if err != nil {
		return nil, fmt.Errorf("failed to start ListCustomers workflow: %w", err)
	}

	// Wait for workflow completion
	var result []*entities.Customer
	if err := run.Get(ctx, &result); err != nil {
		return nil, fmt.Errorf("workflow execution failed: %w", err)
	}

	return result, nil
}
