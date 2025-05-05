package commands

import (
	"context"
	"strings"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/ports"
	"github.com/google/uuid"
)

// CreateUserCommand represents a command to create a user
type CreateUserCommand struct {
	Email     string
	FirstName string
	LastName  string
	Role      string
}

// CreateUserHandler handles the CreateUserCommand
type CreateUserHandler struct {
	userRepo ports.UserRepository
}

// NewCreateUserHandler creates a new CreateUserHandler
func NewCreateUserHandler(userRepo ports.UserRepository) *CreateUserHandler {
	return &CreateUserHandler{
		userRepo: userRepo,
	}
}

// Handle handles the CreateUserCommand
func (h *CreateUserHandler) Handle(ctx context.Context, cmd CreateUserCommand) (*domain.User, error) {
	// Validate command
	if err := validateCreateUserCommand(cmd); err != nil {
		return nil, err
	}

	// Check if user already exists
	existingUser, err := h.userRepo.GetByEmail(ctx, cmd.Email)
	if err != nil {
		return nil, err
	}
	if existingUser != nil {
		return nil, domain.ErrUserAlreadyExists
	}

	// Create user
	user := domain.NewUser(cmd.Email, cmd.FirstName, cmd.LastName, cmd.Role)
	user.ID = uuid.New().String()

	// Save user
	if err := h.userRepo.Create(ctx, user); err != nil {
		return nil, err
	}

	return user, nil
}

// validateCreateUserCommand validates the CreateUserCommand
func validateCreateUserCommand(cmd CreateUserCommand) error {
	if strings.TrimSpace(cmd.Email) == "" {
		return domain.NewValidationError("email", "email is required")
	}
	if strings.TrimSpace(cmd.FirstName) == "" {
		return domain.NewValidationError("firstName", "first name is required")
	}
	if strings.TrimSpace(cmd.LastName) == "" {
		return domain.NewValidationError("lastName", "last name is required")
	}
	if strings.TrimSpace(cmd.Role) == "" {
		return domain.NewValidationError("role", "role is required")
	}
	return nil
}
