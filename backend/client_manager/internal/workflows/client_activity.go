package workflows

import (
	"context"
	"fmt"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/ports/in"
	"github.com/google/uuid"
	"go.temporal.io/sdk/activity"
)

// ClientActivity defines the activities for client operations
type ClientActivity struct {
	clientService in.ClientService
}

// NewClientActivity creates a new client activity
func NewClientActivity(clientService in.ClientService) *ClientActivity {
	return &ClientActivity{
		clientService: clientService,
	}
}

// AddClientActivity adds a new client
func (a *ClientActivity) AddClientActivity(ctx context.Context, client *entities.Client) (*entities.Client, error) {
	logger := activity.GetLogger(ctx)
	logger.Info("AddClientActivity started", "clientUUID", client.UUID)

	// Validate client data
	if client.UUID == uuid.Nil {
		return nil, fmt.Errorf("client UUID is required")
	}
	if client.FirstName == "" {
		return nil, fmt.Errorf("client first name is required")
	}
	if client.LastName == "" {
		return nil, fmt.Errorf("client last name is required")
	}
	if client.ContactEmail == "" {
		return nil, fmt.Errorf("client contact email is required")
	}

	// Add client
	err := a.clientService.AddClient(ctx, client)
	if err != nil {
		logger.Error("Failed to add client", "error", err)
		return nil, fmt.Errorf("failed to add client: %w", err)
	}

	// Get the client to return the complete data
	result, err := a.clientService.GetClient(ctx, client.UUID)
	if err != nil {
		logger.Error("Failed to retrieve client after adding", "error", err)
		return nil, fmt.Errorf("failed to retrieve client after adding: %w", err)
	}

	logger.Info("AddClientActivity completed successfully", "clientUUID", result.UUID)
	return result, nil
}

// GetClientActivity retrieves a client by UUID
func (a *ClientActivity) GetClientActivity(ctx context.Context, id uuid.UUID) (*entities.Client, error) {
	logger := activity.GetLogger(ctx)
	logger.Info("GetClientActivity started", "clientUUID", id)

	// Validate UUID
	if id == uuid.Nil {
		return nil, fmt.Errorf("client UUID is required")
	}

	// Get client
	client, err := a.clientService.GetClient(ctx, id)
	if err != nil {
		logger.Error("Failed to retrieve client", "error", err)
		return nil, fmt.Errorf("failed to retrieve client: %w", err)
	}

	logger.Info("GetClientActivity completed successfully", "clientUUID", id, "clientFound", !client.IsEmpty())
	return client, nil
}
