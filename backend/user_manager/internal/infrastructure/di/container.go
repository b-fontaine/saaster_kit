package di

import (
	"database/sql"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/adapters/http/handlers"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/adapters/repositories/memory"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/adapters/repositories/postgres"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/application/commands"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/application/queries"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/ports"
)

// Container is a dependency injection container
type Container struct {
	// Repositories
	UserRepository ports.UserRepository

	// Command Handlers
	CreateUserHandler *commands.CreateUserHandler
	UpdateUserHandler *commands.UpdateUserHandler
	DeleteUserHandler *commands.DeleteUserHandler

	// Query Handlers
	GetUserByIDHandler *queries.GetUserByIDHandler
	ListUsersHandler   *queries.ListUsersHandler

	// HTTP Handlers
	UserHandler *handlers.UserHandler
}

// NewContainer creates a new dependency injection container
func NewContainer(db *sql.DB, useInMemoryRepo bool) *Container {
	container := &Container{}

	// Initialize repositories
	if useInMemoryRepo {
		container.UserRepository = memory.NewUserRepository()
	} else {
		container.UserRepository = postgres.NewUserRepository(db)
	}

	// Initialize command handlers
	container.CreateUserHandler = commands.NewCreateUserHandler(container.UserRepository)
	container.UpdateUserHandler = commands.NewUpdateUserHandler(container.UserRepository)
	container.DeleteUserHandler = commands.NewDeleteUserHandler(container.UserRepository)

	// Initialize query handlers
	container.GetUserByIDHandler = queries.NewGetUserByIDHandler(container.UserRepository)
	container.ListUsersHandler = queries.NewListUsersHandler(container.UserRepository)

	// Initialize HTTP handlers
	container.UserHandler = handlers.NewUserHandler(
		container.CreateUserHandler,
		container.UpdateUserHandler,
		container.DeleteUserHandler,
		container.GetUserByIDHandler,
		container.ListUsersHandler,
	)

	return container
}
