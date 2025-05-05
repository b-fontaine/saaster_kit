package memory

import (
	"context"
	"sync"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/ports"
)

// UserRepository is an in-memory implementation of the UserRepository interface
type UserRepository struct {
	users map[string]*domain.User
	mutex sync.RWMutex
}

// NewUserRepository creates a new in-memory UserRepository
func NewUserRepository() ports.UserRepository {
	return &UserRepository{
		users: make(map[string]*domain.User),
	}
}

// Create creates a new user in memory
func (r *UserRepository) Create(ctx context.Context, user *domain.User) error {
	r.mutex.Lock()
	defer r.mutex.Unlock()

	// Check if user with the same email already exists
	for _, existingUser := range r.users {
		if existingUser.Email == user.Email {
			return domain.ErrUserAlreadyExists
		}
	}

	// Clone the user to avoid external modifications
	clonedUser := cloneUser(user)
	r.users[user.ID] = clonedUser

	return nil
}

// Update updates a user in memory
func (r *UserRepository) Update(ctx context.Context, user *domain.User) error {
	r.mutex.Lock()
	defer r.mutex.Unlock()

	// Check if user exists
	if _, exists := r.users[user.ID]; !exists {
		return domain.ErrUserNotFound
	}

	// Check if email is already used by another user
	for id, existingUser := range r.users {
		if existingUser.Email == user.Email && id != user.ID {
			return domain.ErrUserAlreadyExists
		}
	}

	// Clone the user to avoid external modifications
	clonedUser := cloneUser(user)
	clonedUser.UpdatedAt = time.Now()
	r.users[user.ID] = clonedUser

	return nil
}

// Delete deletes a user from memory
func (r *UserRepository) Delete(ctx context.Context, id string) error {
	r.mutex.Lock()
	defer r.mutex.Unlock()

	// Check if user exists
	if _, exists := r.users[id]; !exists {
		return domain.ErrUserNotFound
	}

	// Delete user
	delete(r.users, id)

	return nil
}

// GetByID retrieves a user by ID from memory
func (r *UserRepository) GetByID(ctx context.Context, id string) (*domain.User, error) {
	r.mutex.RLock()
	defer r.mutex.RUnlock()

	// Check if user exists
	user, exists := r.users[id]
	if !exists {
		return nil, nil
	}

	// Clone the user to avoid external modifications
	return cloneUser(user), nil
}

// GetByEmail retrieves a user by email from memory
func (r *UserRepository) GetByEmail(ctx context.Context, email string) (*domain.User, error) {
	r.mutex.RLock()
	defer r.mutex.RUnlock()

	// Find user by email
	for _, user := range r.users {
		if user.Email == email {
			// Clone the user to avoid external modifications
			return cloneUser(user), nil
		}
	}

	return nil, nil
}

// List retrieves all users from memory
func (r *UserRepository) List(ctx context.Context) ([]*domain.User, error) {
	r.mutex.RLock()
	defer r.mutex.RUnlock()

	// Create a list of users
	users := make([]*domain.User, 0, len(r.users))
	for _, user := range r.users {
		// Clone the user to avoid external modifications
		users = append(users, cloneUser(user))
	}

	return users, nil
}

// Clear clears all users from memory (useful for testing)
func (r *UserRepository) Clear() {
	r.mutex.Lock()
	defer r.mutex.Unlock()

	r.users = make(map[string]*domain.User)
}

// Helper function to clone a user
func cloneUser(user *domain.User) *domain.User {
	return &domain.User{
		ID:        user.ID,
		Email:     user.Email,
		FirstName: user.FirstName,
		LastName:  user.LastName,
		Role:      user.Role,
		Active:    user.Active,
		CreatedAt: user.CreatedAt,
		UpdatedAt: user.UpdatedAt,
	}
}
