package queries

import (
	"context"
	"strings"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/ports"
)

// GetUserByIDQuery represents a query to get a user by ID
type GetUserByIDQuery struct {
	ID string
}

// GetUserByIDHandler handles the GetUserByIDQuery
type GetUserByIDHandler struct {
	userRepo ports.UserRepository
}

// NewGetUserByIDHandler creates a new GetUserByIDHandler
func NewGetUserByIDHandler(userRepo ports.UserRepository) *GetUserByIDHandler {
	return &GetUserByIDHandler{
		userRepo: userRepo,
	}
}

// Handle handles the GetUserByIDQuery
func (h *GetUserByIDHandler) Handle(ctx context.Context, query GetUserByIDQuery) (*domain.User, error) {
	// Validate query
	if err := validateGetUserByIDQuery(query); err != nil {
		return nil, err
	}

	// Get user
	return h.userRepo.GetByID(ctx, query.ID)
}

// validateGetUserByIDQuery validates the GetUserByIDQuery
func validateGetUserByIDQuery(query GetUserByIDQuery) error {
	if strings.TrimSpace(query.ID) == "" {
		return domain.NewValidationError("id", "id is required")
	}
	return nil
}

// GetUserByEmailQuery represents a query to get a user by email
type GetUserByEmailQuery struct {
	Email string
}

// GetUserByEmailHandler handles the GetUserByEmailQuery
type GetUserByEmailHandler struct {
	userRepo ports.UserRepository
}

// NewGetUserByEmailHandler creates a new GetUserByEmailHandler
func NewGetUserByEmailHandler(userRepo ports.UserRepository) *GetUserByEmailHandler {
	return &GetUserByEmailHandler{
		userRepo: userRepo,
	}
}

// Handle handles the GetUserByEmailQuery
func (h *GetUserByEmailHandler) Handle(ctx context.Context, query GetUserByEmailQuery) (*domain.User, error) {
	// Validate query
	if err := validateGetUserByEmailQuery(query); err != nil {
		return nil, err
	}

	// Get user
	return h.userRepo.GetByEmail(ctx, query.Email)
}

// validateGetUserByEmailQuery validates the GetUserByEmailQuery
func validateGetUserByEmailQuery(query GetUserByEmailQuery) error {
	if strings.TrimSpace(query.Email) == "" {
		return domain.NewValidationError("email", "email is required")
	}
	return nil
}
