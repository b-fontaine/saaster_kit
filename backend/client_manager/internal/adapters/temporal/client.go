package temporal

import (
	"context"
	"fmt"
	"go.temporal.io/api/workflowservice/v1"
	"go.temporal.io/sdk/temporal"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/google/uuid"
	"go.temporal.io/sdk/client"
)

// TemporalClient is a wrapper for the Temporal client
type TemporalClient struct {
	client    client.Client
	namespace string
	taskQueue string
}

// NewTemporalClient creates a new Temporal client
func NewTemporalClient(temporalAddress, namespace, taskQueue string) (*TemporalClient, error) {
	nsClient, err := client.NewNamespaceClient(client.Options{
		HostPort: temporalAddress,
	})
	err = nsClient.Register(context.Background(), &workflowservice.RegisterNamespaceRequest{
		Namespace: namespace,
	})

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

// Close closes the Temporal client
func (c *TemporalClient) Close() {
	if c.client != nil {
		c.client.Close()
	}
}

// AddClient starts the AddClient workflow
func (c *TemporalClient) AddClient(ctx context.Context, clientEntity *entities.Client) (*entities.Client, error) {
	workflowID := fmt.Sprintf("add-client-%s", clientEntity.UUID.String())
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
	run, err := c.client.ExecuteWorkflow(ctx, workflowOptions, "AddClientWorkflow", clientEntity)
	if err != nil {
		return nil, fmt.Errorf("failed to start AddClient workflow: %w", err)
	}

	// Wait for workflow completion
	var result entities.Client
	if err := run.Get(ctx, &result); err != nil {
		return nil, fmt.Errorf("workflow execution failed: %w", err)
	}

	return &result, nil
}

// GetClient starts the GetClient workflow
func (c *TemporalClient) GetClient(ctx context.Context, id uuid.UUID) (*entities.Client, error) {
	workflowID := fmt.Sprintf("get-client-%s", id.String())
	workflowOptions := client.StartWorkflowOptions{
		ID:        workflowID,
		TaskQueue: c.taskQueue,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumInterval:    time.Minute,
			MaximumAttempts:    3,
		},
	}

	// Start workflow
	run, err := c.client.ExecuteWorkflow(ctx, workflowOptions, "GetClientWorkflow", id)
	if err != nil {
		return nil, fmt.Errorf("failed to start GetClient workflow: %w", err)
	}

	// Wait for workflow completion
	var result entities.Client
	if err := run.Get(ctx, &result); err != nil {
		return nil, fmt.Errorf("workflow execution failed: %w", err)
	}

	return &result, nil
}
