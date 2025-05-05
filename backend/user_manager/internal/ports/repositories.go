package ports

import (
	"context"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
)

// UserRepository defines the interface for user repository operations
type UserRepository interface {
	// Command methods (write operations)
	Create(ctx context.Context, user *domain.User) error
	Update(ctx context.Context, user *domain.User) error
	Delete(ctx context.Context, id string) error

	// Query methods (read operations)
	GetByID(ctx context.Context, id string) (*domain.User, error)
	GetByEmail(ctx context.Context, email string) (*domain.User, error)
	List(ctx context.Context) ([]*domain.User, error)
}
