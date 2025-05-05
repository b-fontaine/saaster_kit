package commands

import (
	"context"
	"strings"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/ports"
)

// DeleteUserCommand represents a command to delete a user
type DeleteUserCommand struct {
	ID string
}

// DeleteUserHandler handles the DeleteUserCommand
type DeleteUserHandler struct {
	userRepo ports.UserRepository
}

// NewDeleteUserHandler creates a new DeleteUserHandler
func NewDeleteUserHandler(userRepo ports.UserRepository) *DeleteUserHandler {
	return &DeleteUserHandler{
		userRepo: userRepo,
	}
}

// Handle handles the DeleteUserCommand
func (h *DeleteUserHandler) Handle(ctx context.Context, cmd DeleteUserCommand) error {
	// Validate command
	if err := validateDeleteUserCommand(cmd); err != nil {
		return err
	}

	// Check if user exists
	user, err := h.userRepo.GetByID(ctx, cmd.ID)
	if err != nil {
		return err
	}
	if user == nil {
		return domain.ErrUserNotFound
	}

	// Delete user
	return h.userRepo.Delete(ctx, cmd.ID)
}

// validateDeleteUserCommand validates the DeleteUserCommand
func validateDeleteUserCommand(cmd DeleteUserCommand) error {
	if strings.TrimSpace(cmd.ID) == "" {
		return domain.NewValidationError("id", "id is required")
	}
	return nil
}
