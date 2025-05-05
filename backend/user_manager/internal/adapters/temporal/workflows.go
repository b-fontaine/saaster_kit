package temporal

import (
	"context"
	"go.temporal.io/sdk/activity"
	"go.temporal.io/sdk/worker"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/application/commands"
	_ "github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
	"go.temporal.io/sdk/temporal"
	"go.temporal.io/sdk/workflow"
)

// CreateUserWorkflow is a workflow that creates a user
type CreateUserWorkflow struct {
	createUserHandler *commands.CreateUserHandler
}

// NewCreateUserWorkflow creates a new CreateUserWorkflow
func NewCreateUserWorkflow(createUserHandler *commands.CreateUserHandler) *CreateUserWorkflow {
	return &CreateUserWorkflow{
		createUserHandler: createUserHandler,
	}
}

// CreateUserWorkflowInput represents the input for the CreateUserWorkflow
type CreateUserWorkflowInput struct {
	Email     string
	FirstName string
	LastName  string
	Role      string
}

// CreateUserWorkflowOutput represents the output of the CreateUserWorkflow
type CreateUserWorkflowOutput struct {
	ID        string
	Email     string
	FirstName string
	LastName  string
	Role      string
	Active    bool
	CreatedAt time.Time
	UpdatedAt time.Time
}

// Execute executes the CreateUserWorkflow
func (w *CreateUserWorkflow) Execute(ctx workflow.Context, input CreateUserWorkflowInput) (*CreateUserWorkflowOutput, error) {
	logger := workflow.GetLogger(ctx)
	logger.Info("CreateUserWorkflow started", "email", input.Email)

	var output CreateUserWorkflowOutput

	// Define activity options
	activityOptions := workflow.ActivityOptions{
		StartToCloseTimeout: 10 * time.Second,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}
	ctx = workflow.WithActivityOptions(ctx, activityOptions)

	// Execute the activity to create a user
	err := workflow.ExecuteActivity(ctx, w.CreateUserActivity, input).Get(ctx, &output)
	if err != nil {
		logger.Error("CreateUserActivity failed", "error", err)
		return nil, err
	}

	logger.Info("CreateUserWorkflow completed", "id", output.ID)
	return &output, nil
}

// CreateUserActivity is an activity that creates a user
func (w *CreateUserWorkflow) CreateUserActivity(ctx context.Context, input CreateUserWorkflowInput) (*CreateUserWorkflowOutput, error) {
	// Create command
	cmd := commands.CreateUserCommand{
		Email:     input.Email,
		FirstName: input.FirstName,
		LastName:  input.LastName,
		Role:      input.Role,
	}

	// Handle command
	user, err := w.createUserHandler.Handle(ctx, cmd)
	if err != nil {
		return nil, err
	}

	// Map to output
	return &CreateUserWorkflowOutput{
		ID:        user.ID,
		Email:     user.Email,
		FirstName: user.FirstName,
		LastName:  user.LastName,
		Role:      user.Role,
		Active:    user.Active,
		CreatedAt: user.CreatedAt,
		UpdatedAt: user.UpdatedAt,
	}, nil
}

// Worker represents a Temporal worker
type Worker struct {
	createUserWorkflow *CreateUserWorkflow
	// Add other workflows here
}

// NewWorker creates a new Worker
func NewWorker(createUserWorkflow *CreateUserWorkflow) *Worker {
	return &Worker{
		createUserWorkflow: createUserWorkflow,
	}
}

// RegisterWorkflows registers all workflows
func (w *Worker) RegisterWorkflows(registry worker.Registry) {
	registry.RegisterWorkflowWithOptions(
		w.createUserWorkflow.Execute,
		workflow.RegisterOptions{Name: "CreateUserWorkflow"},
	)
}

// RegisterActivities registers all activities
func (w *Worker) RegisterActivities(registry worker.Registry) {
	registry.RegisterActivityWithOptions(
		w.createUserWorkflow.CreateUserActivity,
		activity.RegisterOptions{Name: "CreateUserActivity"},
	)
}
