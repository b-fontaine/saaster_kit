package out

import (
	"context"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/domain/entities"
	"github.com/google/uuid"
)

// CustomerRepository defines the interface for customer persistence
type CustomerRepository interface {
	// Save persists a customer to the database
	Save(ctx context.Context, customer *entities.Customer) error

	// FindByID retrieves a customer by UUID
	FindByID(ctx context.Context, id uuid.UUID) (*entities.Customer, error)

	// Update updates an existing customer
	Update(ctx context.Context, customer *entities.Customer) error

	// FindAll retrieves all customers
	FindAll(ctx context.Context) ([]*entities.Customer, error)
}
