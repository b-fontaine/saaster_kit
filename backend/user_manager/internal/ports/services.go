package ports

import (
	"context"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
)

// UserCommandService defines the interface for user command operations
type UserCommandService interface {
	CreateUser(ctx context.Context, email, firstName, lastName, role string) (*domain.User, error)
	UpdateUser(ctx context.Context, id, email, firstName, lastName, role string) (*domain.User, error)
	DeleteUser(ctx context.Context, id string) error
	ActivateUser(ctx context.Context, id string) error
	DeactivateUser(ctx context.Context, id string) error
}

// UserQueryService defines the interface for user query operations
type UserQueryService interface {
	GetUserByID(ctx context.Context, id string) (*domain.User, error)
	GetUserByEmail(ctx context.Context, email string) (*domain.User, error)
	ListUsers(ctx context.Context) ([]*domain.User, error)
}
