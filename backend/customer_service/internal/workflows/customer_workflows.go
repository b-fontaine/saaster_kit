package workflows

import (
	"time"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/domain/entities"
	"github.com/google/uuid"
	"go.temporal.io/sdk/temporal"
	"go.temporal.io/sdk/workflow"
)

// AddCustomerWorkflow is the workflow for adding a customer
func AddCustomerWorkflow(ctx workflow.Context, customer *entities.Customer) (*entities.Customer, error) {
	options := workflow.ActivityOptions{
		StartToCloseTimeout: 10 * time.Second,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}
	ctx = workflow.WithActivityOptions(ctx, options)

	var result entities.Customer
	err := workflow.ExecuteActivity(ctx, "AddCustomerActivity", customer).Get(ctx, &result)
	if err != nil {
		return nil, err
	}

	return &result, nil
}

// GetCustomerWorkflow is the workflow for retrieving a customer
func GetCustomerWorkflow(ctx workflow.Context, customerID uuid.UUID) (*entities.Customer, error) {
	options := workflow.ActivityOptions{
		StartToCloseTimeout: 10 * time.Second,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}
	ctx = workflow.WithActivityOptions(ctx, options)

	var result entities.Customer
	err := workflow.ExecuteActivity(ctx, "GetCustomerActivity", customerID).Get(ctx, &result)
	if err != nil {
		return nil, err
	}

	return &result, nil
}

// UpdateCustomerWorkflow is the workflow for updating a customer
func UpdateCustomerWorkflow(ctx workflow.Context, customer *entities.Customer) (*entities.Customer, error) {
	options := workflow.ActivityOptions{
		StartToCloseTimeout: 10 * time.Second,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}
	ctx = workflow.WithActivityOptions(ctx, options)

	var result entities.Customer
	err := workflow.ExecuteActivity(ctx, "UpdateCustomerActivity", customer).Get(ctx, &result)
	if err != nil {
		return nil, err
	}

	return &result, nil
}

// ListCustomersWorkflow is the workflow for listing customers
func ListCustomersWorkflow(ctx workflow.Context) ([]*entities.Customer, error) {
	options := workflow.ActivityOptions{
		StartToCloseTimeout: 10 * time.Second,
		RetryPolicy: &temporal.RetryPolicy{
			InitialInterval:    time.Second,
			BackoffCoefficient: 2.0,
			MaximumAttempts:    3,
		},
	}
	ctx = workflow.WithActivityOptions(ctx, options)

	var result []*entities.Customer
	err := workflow.ExecuteActivity(ctx, "ListCustomersActivity").Get(ctx, &result)
	if err != nil {
		return nil, err
	}

	return result, nil
}
