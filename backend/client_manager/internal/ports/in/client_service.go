package in

import (
	"context"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/google/uuid"
)

// ClientService defines the interface for client operations
type ClientService interface {
	// AddClient adds a new client to the system
	AddClient(ctx context.Context, client *entities.Client) error
	
	// GetClient retrieves a client by UUID
	GetClient(ctx context.Context, id uuid.UUID) (*entities.Client, error)
}
