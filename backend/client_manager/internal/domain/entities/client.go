package entities

import (
	"github.com/google/uuid"
)

// Client represents a client in the system
type Client struct {
	UUID         uuid.UUID `json:"uuid"`
	FirstName    string    `json:"firstName"`
	LastName     string    `json:"lastName"`
	ContactEmail string    `json:"contactEmail"`
	PhoneNumber  string    `json:"phoneNumber"`
}

// NewClient creates a new client with the given UUID
func NewClient(id uuid.UUID, firstName, lastName, contactEmail, phoneNumber string) *Client {
	return &Client{
		UUID:         id,
		FirstName:    firstName,
		LastName:     lastName,
		ContactEmail: contactEmail,
		PhoneNumber:  phoneNumber,
	}
}

// IsEmpty checks if the client has any data
func (c *Client) IsEmpty() bool {
	return c.FirstName == "" && c.LastName == "" && c.ContactEmail == "" && c.PhoneNumber == ""
}
