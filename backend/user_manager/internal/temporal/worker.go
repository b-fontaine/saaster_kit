package temporal

import (
	"context"
	"fmt"
	"go.temporal.io/sdk/temporal"
	"go.temporal.io/sdk/workflow"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/config"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/models"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/repository"
	"go.temporal.io/sdk/client"
	"go.temporal.io/sdk/worker"
)

// Worker represents a Temporal worker
type Worker struct {
	client     client.Client              `json:"client,omitempty"`
	worker     worker.Worker              `json:"worker,omitempty"`
	userRepo   *repository.UserRepository `json:"user_repo,omitempty"`
	taskQueue  string                     `json:"task_queue,omitempty"`
	workerName string                     `json:"worker_name,omitempty"`
}

// NewWorker creates a new Temporal worker
func NewWorker(cfg config.TemporalConfig, userRepo *repository.UserRepository) (*Worker, error) {
	c, err := client.NewClient(client.Options{
		HostPort:  cfg.Address,
		Namespace: cfg.Namespace,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to create Temporal client: %w", err)
	}

	w := worker.New(c, cfg.TaskQueue, worker.Options{
		Identity: cfg.WorkerName,
	})

	temporalWorker := &Worker{
		client:     c,
		worker:     w,
		userRepo:   userRepo,
		taskQueue:  cfg.TaskQueue,
		workerName: cfg.WorkerName,
	}

	// Register workflows and activities
	w.RegisterWorkflow(temporalWorker.CreateUserWorkflow)
	w.RegisterActivity(temporalWorker.CreateUserActivity)

	return temporalWorker, nil
}

// Start starts the Temporal worker
func (w *Worker) Start() error {
	return w.worker.Run(worker.InterruptCh())
}

// Stop stops the Temporal worker
func (w *Worker) Stop() {
	w.worker.Stop()
	w.client.Close()
}

// CreateUserWorkflow is a workflow that creates a user
func (w *Worker) CreateUserWorkflow(ctx workflow.Context, req models.CreateUserRequest) (*models.UserResponse, error) {
	var userResponse models.UserResponse

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
	err := workflow.ExecuteActivity(ctx, w.CreateUserActivity, req).Get(ctx, &userResponse)
	if err != nil {
		return nil, fmt.Errorf("failed to execute CreateUserActivity: %w", err)
	}

	return &userResponse, nil
}

// CreateUserActivity is an activity that creates a user
func (w *Worker) CreateUserActivity(ctx context.Context, req models.CreateUserRequest) (*models.UserResponse, error) {
	// Check if user already exists
	existingUser, err := w.userRepo.GetUserByEmail(ctx, req.Email)
	if err != nil {
		return nil, fmt.Errorf("failed to check if user exists: %w", err)
	}
	if existingUser != nil {
		return nil, fmt.Errorf("user with email %s already exists", req.Email)
	}

	// Create user
	user, err := w.userRepo.CreateUser(ctx, req)
	if err != nil {
		return nil, fmt.Errorf("failed to create user: %w", err)
	}

	// Map to response
	response := &models.UserResponse{
		ID:        user.ID,
		Email:     user.Email,
		FirstName: user.FirstName,
		LastName:  user.LastName,
		Role:      user.Role,
		Active:    user.Active,
		CreatedAt: user.CreatedAt,
		UpdatedAt: user.UpdatedAt,
	}

	return response, nil
}
