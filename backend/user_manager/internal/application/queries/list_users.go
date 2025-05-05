package queries

import (
	"context"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/ports"
)

// ListUsersQuery represents a query to list users
type ListUsersQuery struct {
	// Add filters here if needed
}

// ListUsersHandler handles the ListUsersQuery
type ListUsersHandler struct {
	userRepo ports.UserRepository
}

// NewListUsersHandler creates a new ListUsersHandler
func NewListUsersHandler(userRepo ports.UserRepository) *ListUsersHandler {
	return &ListUsersHandler{
		userRepo: userRepo,
	}
}

// Handle handles the ListUsersQuery
func (h *ListUsersHandler) Handle(ctx context.Context, query ListUsersQuery) ([]*domain.User, error) {
	// Get users
	return h.userRepo.List(ctx)
}
