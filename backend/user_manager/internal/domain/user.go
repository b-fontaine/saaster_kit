package domain

import (
	"time"
)

// User represents a user entity in the domain
type User struct {
	ID        string
	Email     string
	FirstName string
	LastName  string
	Role      string
	Active    bool
	CreatedAt time.Time
	UpdatedAt time.Time
}

// NewUser creates a new user with default values
func NewUser(email, firstName, lastName, role string) *User {
	now := time.Now()
	return &User{
		Email:     email,
		FirstName: firstName,
		LastName:  lastName,
		Role:      role,
		Active:    true,
		CreatedAt: now,
		UpdatedAt: now,
	}
}

// FullName returns the user's full name
func (u *User) FullName() string {
	return u.FirstName + " " + u.LastName
}

// Activate activates the user
func (u *User) Activate() {
	u.Active = true
	u.UpdatedAt = time.Now()
}

// Deactivate deactivates the user
func (u *User) Deactivate() {
	u.Active = false
	u.UpdatedAt = time.Now()
}

// Update updates the user's information
func (u *User) Update(email, firstName, lastName, role string) {
	u.Email = email
	u.FirstName = firstName
	u.LastName = lastName
	u.Role = role
	u.UpdatedAt = time.Now()
}
