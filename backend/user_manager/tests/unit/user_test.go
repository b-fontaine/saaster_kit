package unit

import (
	"context"
	"testing"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/models"
	"github.com/stretchr/testify/assert"
)

// MockUserRepository is a mock implementation of the user repository
type MockUserRepository struct {
	users map[string]*models.User
}

// NewMockUserRepository creates a new mock user repository
func NewMockUserRepository() *MockUserRepository {
	return &MockUserRepository{
		users: make(map[string]*models.User),
	}
}

// CreateUser creates a new user in the mock repository
func (r *MockUserRepository) CreateUser(ctx context.Context, req models.CreateUserRequest) (*models.User, error) {
	user := &models.User{
		ID:        "mock-id",
		Email:     req.Email,
		FirstName: req.FirstName,
		LastName:  req.LastName,
		Role:      req.Role,
		Active:    true,
	}
	r.users[user.ID] = user
	return user, nil
}

// GetUserByID retrieves a user by ID from the mock repository
func (r *MockUserRepository) GetUserByID(ctx context.Context, id string) (*models.User, error) {
	user, ok := r.users[id]
	if !ok {
		return nil, nil
	}
	return user, nil
}

// TestCreateUser tests the user creation functionality
func TestCreateUser(t *testing.T) {
	// Create a mock repository
	repo := NewMockUserRepository()

	// Create a user request
	req := models.CreateUserRequest{
		Email:     "test@example.com",
		FirstName: "Test",
		LastName:  "User",
		Role:      "user",
	}

	// Create a user
	user, err := repo.CreateUser(context.Background(), req)

	// Assert no error occurred
	assert.NoError(t, err)

	// Assert user was created with correct data
	assert.Equal(t, "mock-id", user.ID)
	assert.Equal(t, req.Email, user.Email)
	assert.Equal(t, req.FirstName, user.FirstName)
	assert.Equal(t, req.LastName, user.LastName)
	assert.Equal(t, req.Role, user.Role)
	assert.True(t, user.Active)

	// Retrieve the user by ID
	retrievedUser, err := repo.GetUserByID(context.Background(), user.ID)

	// Assert no error occurred
	assert.NoError(t, err)

	// Assert retrieved user matches created user
	assert.Equal(t, user.ID, retrievedUser.ID)
	assert.Equal(t, user.Email, retrievedUser.Email)
}
