package workflows

import (
	"context"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/domain/entities"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/ports/in"
	"github.com/google/uuid"
)

// Activities holds references to services needed by activities
type Activities struct {
	CustomerService in.CustomerService
}

// NewActivities creates a new Activities instance
func NewActivities(customerService in.CustomerService) *Activities {
	return &Activities{
		CustomerService: customerService,
	}
}

// AddCustomerActivity is the activity for adding a customer
func (a *Activities) AddCustomerActivity(ctx context.Context, customer *entities.Customer) (*entities.Customer, error) {
	// Add customer
	err := a.CustomerService.AddCustomer(ctx, customer)
	if err != nil {
		return nil, err
	}

	// Return the customer
	return customer, nil
}

// GetCustomerActivity is the activity for retrieving a customer
func (a *Activities) GetCustomerActivity(ctx context.Context, customerID uuid.UUID) (*entities.Customer, error) {
	// Get customer
	customer, err := a.CustomerService.GetCustomer(ctx, customerID)
	if err != nil {
		return nil, err
	}

	// Return the customer
	return customer, nil
}

// UpdateCustomerActivity is the activity for updating a customer
func (a *Activities) UpdateCustomerActivity(ctx context.Context, customer *entities.Customer) (*entities.Customer, error) {
	// Update customer
	err := a.CustomerService.UpdateCustomer(ctx, customer)
	if err != nil {
		return nil, err
	}

	// Return the updated customer
	return customer, nil
}

// ListCustomersActivity is the activity for listing customers
func (a *Activities) ListCustomersActivity(ctx context.Context) ([]*entities.Customer, error) {
	// List customers
	customers, err := a.CustomerService.ListCustomers(ctx)
	if err != nil {
		return nil, err
	}

	// Return the customers
	return customers, nil
}
