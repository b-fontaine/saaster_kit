package commands

import (
	"context"
	"strings"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/ports"
)

// UpdateUserCommand represents a command to update a user
type UpdateUserCommand struct {
	ID        string
	Email     string
	FirstName string
	LastName  string
	Role      string
}

// UpdateUserHandler handles the UpdateUserCommand
type UpdateUserHandler struct {
	userRepo ports.UserRepository
}

// NewUpdateUserHandler creates a new UpdateUserHandler
func NewUpdateUserHandler(userRepo ports.UserRepository) *UpdateUserHandler {
	return &UpdateUserHandler{
		userRepo: userRepo,
	}
}

// Handle handles the UpdateUserCommand
func (h *UpdateUserHandler) Handle(ctx context.Context, cmd UpdateUserCommand) (*domain.User, error) {
	// Validate command
	if err := validateUpdateUserCommand(cmd); err != nil {
		return nil, err
	}

	// Get user
	user, err := h.userRepo.GetByID(ctx, cmd.ID)
	if err != nil {
		return nil, err
	}
	if user == nil {
		return nil, domain.ErrUserNotFound
	}

	// Check if email is already used by another user
	if user.Email != cmd.Email {
		existingUser, err := h.userRepo.GetByEmail(ctx, cmd.Email)
		if err != nil {
			return nil, err
		}
		if existingUser != nil && existingUser.ID != cmd.ID {
			return nil, domain.ErrUserAlreadyExists
		}
	}

	// Update user
	user.Update(cmd.Email, cmd.FirstName, cmd.LastName, cmd.Role)

	// Save user
	if err := h.userRepo.Update(ctx, user); err != nil {
		return nil, err
	}

	return user, nil
}

// validateUpdateUserCommand validates the UpdateUserCommand
func validateUpdateUserCommand(cmd UpdateUserCommand) error {
	if strings.TrimSpace(cmd.ID) == "" {
		return domain.NewValidationError("id", "id is required")
	}
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
