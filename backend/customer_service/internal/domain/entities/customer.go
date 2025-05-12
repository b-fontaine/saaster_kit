package entities

import (
	"github.com/google/uuid"
	"time"
)

// Customer represents a customer in the system
type Customer struct {
	UUID         uuid.UUID `json:"uuid"`
	FirstName    string    `json:"firstName"`
	LastName     string    `json:"lastName"`
	ContactEmail string    `json:"contactEmail"`
	ContactPhone string    `json:"contactPhone"`
	CreatedAt    time.Time `json:"createdAt"`
	UpdatedAt    time.Time `json:"updatedAt"`
}

// NewCustomer creates a new customer with the given UUID
func NewCustomer(id uuid.UUID, firstName, lastName, contactEmail, contactPhone string) *Customer {
	now := time.Now().UTC()
	return &Customer{
		UUID:         id,
		FirstName:    firstName,
		LastName:     lastName,
		ContactEmail: contactEmail,
		ContactPhone: contactPhone,
		CreatedAt:    now,
		UpdatedAt:    now,
	}
}

// IsEmpty checks if the customer has any data
func (c *Customer) IsEmpty() bool {
	return c.FirstName == "" && c.LastName == "" && c.ContactEmail == "" && c.ContactPhone == ""
}

// FullName returns the customer's full name
func (c *Customer) FullName() string {
	return c.FirstName + " " + c.LastName
}

// Update updates the customer's information
func (c *Customer) Update(firstName, lastName, contactEmail, contactPhone string) {
	c.FirstName = firstName
	c.LastName = lastName
	c.ContactEmail = contactEmail
	c.ContactPhone = contactPhone
	c.UpdatedAt = time.Now().UTC()
}

// Validate validates the customer data
func (c *Customer) Validate() error {
	if c.FirstName == "" {
		return ErrEmptyFirstName
	}
	if c.LastName == "" {
		return ErrEmptyLastName
	}
	if c.ContactEmail == "" {
		return ErrEmptyContactEmail
	}
	if c.ContactPhone == "" {
		return ErrEmptyContactPhone
	}
	return nil
}
