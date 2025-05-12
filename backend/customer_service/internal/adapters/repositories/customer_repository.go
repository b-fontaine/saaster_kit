package repositories

import (
	"context"
	"database/sql"
	"fmt"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/domain/entities"
	"github.com/google/uuid"
)

// CustomerRepository implements the customer repository interface
type CustomerRepository struct {
	db *sql.DB
}

// NewCustomerRepository creates a new customer repository
func NewCustomerRepository(db *sql.DB) *CustomerRepository {
	return &CustomerRepository{
		db: db,
	}
}

// Save persists a customer to the database
func (r *CustomerRepository) Save(ctx context.Context, customer *entities.Customer) error {
	query := `
		INSERT INTO customers (uuid, first_name, last_name, contact_email, contact_phone, created_at, updated_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7)
		ON CONFLICT (uuid) 
		DO UPDATE SET 
			first_name = $2,
			last_name = $3,
			contact_email = $4,
			contact_phone = $5,
			updated_at = $7
	`
	
	_, err := r.db.ExecContext(
		ctx,
		query,
		customer.UUID,
		customer.FirstName,
		customer.LastName,
		customer.ContactEmail,
		customer.ContactPhone,
		customer.CreatedAt,
		customer.UpdatedAt,
	)
	
	if err != nil {
		return fmt.Errorf("error saving customer: %w", err)
	}
	
	return nil
}

// FindByID retrieves a customer by UUID
func (r *CustomerRepository) FindByID(ctx context.Context, id uuid.UUID) (*entities.Customer, error) {
	query := `
		SELECT uuid, first_name, last_name, contact_email, contact_phone, created_at, updated_at
		FROM customers
		WHERE uuid = $1
	`
	
	row := r.db.QueryRowContext(ctx, query, id)
	
	var customer entities.Customer
	var createdAt, updatedAt time.Time
	
	err := row.Scan(
		&customer.UUID,
		&customer.FirstName,
		&customer.LastName,
		&customer.ContactEmail,
		&customer.ContactPhone,
		&createdAt,
		&updatedAt,
	)
	
	if err == sql.ErrNoRows {
		return nil, nil
	}
	
	if err != nil {
		return nil, fmt.Errorf("error finding customer: %w", err)
	}
	
	customer.CreatedAt = createdAt
	customer.UpdatedAt = updatedAt
	
	return &customer, nil
}

// Update updates an existing customer
func (r *CustomerRepository) Update(ctx context.Context, customer *entities.Customer) error {
	query := `
		UPDATE customers
		SET first_name = $2,
			last_name = $3,
			contact_email = $4,
			contact_phone = $5,
			updated_at = $6
		WHERE uuid = $1
	`
	
	result, err := r.db.ExecContext(
		ctx,
		query,
		customer.UUID,
		customer.FirstName,
		customer.LastName,
		customer.ContactEmail,
		customer.ContactPhone,
		customer.UpdatedAt,
	)
	
	if err != nil {
		return fmt.Errorf("error updating customer: %w", err)
	}
	
	rowsAffected, err := result.RowsAffected()
	if err != nil {
		return fmt.Errorf("error getting rows affected: %w", err)
	}
	
	if rowsAffected == 0 {
		return entities.ErrCustomerNotFound
	}
	
	return nil
}

// FindAll retrieves all customers
func (r *CustomerRepository) FindAll(ctx context.Context) ([]*entities.Customer, error) {
	query := `
		SELECT uuid, first_name, last_name, contact_email, contact_phone, created_at, updated_at
		FROM customers
		ORDER BY last_name, first_name
	`
	
	rows, err := r.db.QueryContext(ctx, query)
	if err != nil {
		return nil, fmt.Errorf("error querying customers: %w", err)
	}
	defer rows.Close()
	
	var customers []*entities.Customer
	for rows.Next() {
		var customer entities.Customer
		var createdAt, updatedAt time.Time
		
		err := rows.Scan(
			&customer.UUID,
			&customer.FirstName,
			&customer.LastName,
			&customer.ContactEmail,
			&customer.ContactPhone,
			&createdAt,
			&updatedAt,
		)
		if err != nil {
			return nil, fmt.Errorf("error scanning customer row: %w", err)
		}
		
		customer.CreatedAt = createdAt
		customer.UpdatedAt = updatedAt
		
		customers = append(customers, &customer)
	}
	
	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating customer rows: %w", err)
	}
	
	return customers, nil
}
