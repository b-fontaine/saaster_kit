package entities

import "errors"

// Domain errors
var (
	ErrEmptyFirstName    = errors.New("first name cannot be empty")
	ErrEmptyLastName     = errors.New("last name cannot be empty")
	ErrEmptyContactEmail = errors.New("contact email cannot be empty")
	ErrEmptyContactPhone = errors.New("contact phone cannot be empty")
	ErrCustomerNotFound  = errors.New("customer not found")
)
