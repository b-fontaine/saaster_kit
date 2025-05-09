package repositories

import (
	"context"
	"database/sql"
	"fmt"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/google/uuid"
)

// ClientRepository implements the client repository interface
type ClientRepository struct {
	db *sql.DB
}

// NewClientRepository creates a new client repository
func NewClientRepository(db *sql.DB) *ClientRepository {
	return &ClientRepository{
		db: db,
	}
}

// Save persists a client to the database
func (r *ClientRepository) Save(ctx context.Context, client *entities.Client) error {
	query := `
		INSERT INTO clients (uuid, first_name, last_name, contact_email, phone_number)
		VALUES ($1, $2, $3, $4, $5)
		ON CONFLICT (uuid) 
		DO UPDATE SET 
			first_name = $2,
			last_name = $3,
			contact_email = $4,
			phone_number = $5,
			updated_at = CURRENT_TIMESTAMP
	`
	
	_, err := r.db.ExecContext(
		ctx,
		query,
		client.UUID,
		client.FirstName,
		client.LastName,
		client.ContactEmail,
		client.PhoneNumber,
	)
	
	if err != nil {
		return fmt.Errorf("error saving client: %w", err)
	}
	
	return nil
}

// FindByID retrieves a client by UUID
func (r *ClientRepository) FindByID(ctx context.Context, id uuid.UUID) (*entities.Client, error) {
	query := `
		SELECT uuid, first_name, last_name, contact_email, phone_number
		FROM clients
		WHERE uuid = $1
	`
	
	row := r.db.QueryRowContext(ctx, query, id)
	
	var client entities.Client
	err := row.Scan(
		&client.UUID,
		&client.FirstName,
		&client.LastName,
		&client.ContactEmail,
		&client.PhoneNumber,
	)
	
	if err == sql.ErrNoRows {
		return nil, nil
	}
	
	if err != nil {
		return nil, fmt.Errorf("error finding client: %w", err)
	}
	
	return &client, nil
}
