package services

import (
	"context"
	"fmt"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/ports/out"
	"github.com/google/uuid"
)

// ClientService implements the client service interface
type ClientService struct {
	clientRepo out.ClientRepository
}

// NewClientService creates a new client service
func NewClientService(clientRepo out.ClientRepository) *ClientService {
	return &ClientService{
		clientRepo: clientRepo,
	}
}

// AddClient adds a new client to the system
func (s *ClientService) AddClient(ctx context.Context, client *entities.Client) error {
	// Check if client already exists
	existingClient, err := s.clientRepo.FindByID(ctx, client.UUID)
	if err != nil {
		return fmt.Errorf("error checking existing client: %w", err)
	}
	
	if existingClient != nil && !existingClient.IsEmpty() {
		// Update existing client
		return s.clientRepo.Save(ctx, client)
	}
	
	// Save new client
	return s.clientRepo.Save(ctx, client)
}

// GetClient retrieves a client by UUID
func (s *ClientService) GetClient(ctx context.Context, id uuid.UUID) (*entities.Client, error) {
	client, err := s.clientRepo.FindByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("error retrieving client: %w", err)
	}
	
	// If client not found, return empty client
	if client == nil {
		return &entities.Client{UUID: id}, nil
	}
	
	return client, nil
}
