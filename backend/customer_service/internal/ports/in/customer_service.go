package in

import (
	"context"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/domain/entities"
	"github.com/google/uuid"
)

// CustomerService defines the interface for customer operations
type CustomerService interface {
	// AddCustomer adds a new customer to the system
	AddCustomer(ctx context.Context, customer *entities.Customer) error
	
	// GetCustomer retrieves a customer by UUID
	GetCustomer(ctx context.Context, id uuid.UUID) (*entities.Customer, error)
	
	// UpdateCustomer updates an existing customer
	UpdateCustomer(ctx context.Context, customer *entities.Customer) error
	
	// ListCustomers retrieves a list of customers
	ListCustomers(ctx context.Context) ([]*entities.Customer, error)
}
