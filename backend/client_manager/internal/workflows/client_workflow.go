package workflows

import (
	"go.temporal.io/sdk/temporal"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/google/uuid"
	"go.temporal.io/sdk/workflow"
)

// ClientWorkflow defines the interface for client workflows
type ClientWorkflow interface {
	// AddClient adds a new client
	AddClient(ctx workflow.Context, client *entities.Client) (*entities.Client, error)

	// GetClient retrieves a client by UUID
	GetClient(ctx workflow.Context, id uuid.UUID) (*entities.Client, error)
}

// ClientWorkflowImpl implements the ClientWorkflow interface
type ClientWorkflowImpl struct{}

// AddClientWorkflow is the workflow for adding a client
func AddClientWorkflow(ctx workflow.Context, client *entities.Client) (*entities.Client, error) {
	logger := workflow.GetLogger(ctx)
	logger.Info("AddClientWorkflow started", "clientUUID", client.UUID)

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

	// Execute the AddClient activity
	var result entities.Client
	err := workflow.ExecuteActivity(ctx, "AddClientActivity", client).Get(ctx, &result)
	if err != nil {
		logger.Error("AddClientWorkflow failed", "error", err)
		return nil, err
	}

	logger.Info("AddClientWorkflow completed successfully", "clientUUID", result.UUID)
	return &result, nil
}

// GetClientWorkflow is the workflow for retrieving a client
func GetClientWorkflow(ctx workflow.Context, id uuid.UUID) (*entities.Client, error) {
	logger := workflow.GetLogger(ctx)
	logger.Info("GetClientWorkflow started", "clientUUID", id)

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

	// Execute the GetClient activity
	var result entities.Client
	err := workflow.ExecuteActivity(ctx, "GetClientActivity", id).Get(ctx, &result)
	if err != nil {
		logger.Error("GetClientWorkflow failed", "error", err)
		return nil, err
	}

	logger.Info("GetClientWorkflow completed successfully", "clientUUID", result.UUID)
	return &result, nil
}
