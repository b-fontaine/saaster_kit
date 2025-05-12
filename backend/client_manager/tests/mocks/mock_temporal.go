package mocks

import (
	"context"
	"database/sql"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/google/uuid"
)

// MockTemporalClient is a mock implementation of the Temporal client for testing
type MockTemporalClient struct {
	db *sql.DB
}

// NewMockTemporalClient creates a new mock Temporal client
func NewMockTemporalClient(db *sql.DB) *MockTemporalClient {
	return &MockTemporalClient{
		db: db,
	}
}

// IsConnected returns true if the client is connected
func (c *MockTemporalClient) IsConnected() bool {
	return true
}

// Close closes the Temporal client
func (c *MockTemporalClient) Close() {
	// No-op for mock
}

// AddClient mocks the AddClient workflow
func (c *MockTemporalClient) AddClient(ctx context.Context, clientEntity *entities.Client) (*entities.Client, error) {
	// Insert the client into the database directly
	_, err := c.db.ExecContext(ctx,
		"INSERT INTO clients (uuid, first_name, last_name, contact_email, phone_number) VALUES ($1, $2, $3, $4, $5)",
		clientEntity.UUID,
		clientEntity.FirstName,
		clientEntity.LastName,
		clientEntity.ContactEmail,
		clientEntity.PhoneNumber,
	)
	if err != nil {
		return nil, err
	}

	return clientEntity, nil
}

// GetClient mocks the GetClient workflow
func (c *MockTemporalClient) GetClient(ctx context.Context, id uuid.UUID) (*entities.Client, error) {
	// Query the client from the database directly
	var client entities.Client
	err := c.db.QueryRowContext(ctx,
		"SELECT uuid, first_name, last_name, contact_email, phone_number FROM clients WHERE uuid = $1",
		id,
	).Scan(
		&client.UUID,
		&client.FirstName,
		&client.LastName,
		&client.ContactEmail,
		&client.PhoneNumber,
	)

	if err == sql.ErrNoRows {
		// Return an empty client with the requested UUID
		return &entities.Client{UUID: id}, nil
	} else if err != nil {
		return nil, err
	}

	return &client, nil
}
