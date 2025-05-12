package services

import (
	"context"
	"fmt"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/domain/entities"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/ports/out"
	"github.com/google/uuid"
)

// CustomerService implements the customer service interface
type CustomerService struct {
	customerRepo out.CustomerRepository
}

// NewCustomerService creates a new customer service
func NewCustomerService(customerRepo out.CustomerRepository) *CustomerService {
	return &CustomerService{
		customerRepo: customerRepo,
	}
}

// AddCustomer adds a new customer to the system
func (s *CustomerService) AddCustomer(ctx context.Context, customer *entities.Customer) error {
	// Validate customer data
	if err := customer.Validate(); err != nil {
		return fmt.Errorf("invalid customer data: %w", err)
	}
	
	// Check if customer already exists
	existingCustomer, err := s.customerRepo.FindByID(ctx, customer.UUID)
	if err != nil {
		return fmt.Errorf("error checking existing customer: %w", err)
	}
	
	if existingCustomer != nil && !existingCustomer.IsEmpty() {
		// Update existing customer
		return s.customerRepo.Save(ctx, customer)
	}
	
	// Save new customer
	return s.customerRepo.Save(ctx, customer)
}

// GetCustomer retrieves a customer by UUID
func (s *CustomerService) GetCustomer(ctx context.Context, id uuid.UUID) (*entities.Customer, error) {
	customer, err := s.customerRepo.FindByID(ctx, id)
	if err != nil {
		return nil, fmt.Errorf("error retrieving customer: %w", err)
	}
	
	// If customer not found, return empty customer
	if customer == nil {
		return &entities.Customer{UUID: id}, nil
	}
	
	return customer, nil
}

// UpdateCustomer updates an existing customer
func (s *CustomerService) UpdateCustomer(ctx context.Context, customer *entities.Customer) error {
	// Validate customer data
	if err := customer.Validate(); err != nil {
		return fmt.Errorf("invalid customer data: %w", err)
	}
	
	// Check if customer exists
	existingCustomer, err := s.customerRepo.FindByID(ctx, customer.UUID)
	if err != nil {
		return fmt.Errorf("error checking existing customer: %w", err)
	}
	
	if existingCustomer == nil || existingCustomer.IsEmpty() {
		return entities.ErrCustomerNotFound
	}
	
	// Update customer
	return s.customerRepo.Update(ctx, customer)
}

// ListCustomers retrieves a list of customers
func (s *CustomerService) ListCustomers(ctx context.Context) ([]*entities.Customer, error) {
	return s.customerRepo.FindAll(ctx)
}
