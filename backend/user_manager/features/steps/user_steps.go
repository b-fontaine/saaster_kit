package steps

import (
	"context"
	"fmt"
	_ "log"
	_ "net/http"
	"net/http/httptest"
	"os"
	"testing"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/adapters/repositories/memory"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/application/commands"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/application/queries"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/infrastructure/di"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/ports"
	"github.com/cucumber/godog"
	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

// UserContext holds the context for the user management feature tests
type UserContext struct {
	userRepo       ports.UserRepository
	memoryRepo     *memory.UserRepository
	testServer     *httptest.Server
	currentUser    *domain.User
	users          []*domain.User
	lastStatusCode int
	lastError      error
}

// NewUserContext creates a new UserContext
func NewUserContext() *UserContext {
	return &UserContext{}
}

// InitializeScenario initializes the scenario
func (c *UserContext) InitializeScenario(ctx *godog.ScenarioContext) {
	// Background steps
	ctx.Step(`^the system is running$`, c.theSystemIsRunning)
	ctx.Step(`^the database is clean$`, c.theDatabaseIsClean)

	// Create user steps
	ctx.Step(`^I create a user with the following details:$`, c.iCreateAUserWithTheFollowingDetails)
	ctx.Step(`^the user should be created successfully$`, c.theUserShouldBeCreatedSuccessfully)

	// Get user steps
	ctx.Step(`^a user exists with the following details:$`, c.aUserExistsWithTheFollowingDetails)
	ctx.Step(`^I get the user by ID$`, c.iGetTheUserByID)
	ctx.Step(`^I should receive the user details$`, c.iShouldReceiveTheUserDetails)

	// Update user steps
	ctx.Step(`^I update the user with the following details:$`, c.iUpdateTheUserWithTheFollowingDetails)
	ctx.Step(`^the user should be updated successfully$`, c.theUserShouldBeUpdatedSuccessfully)

	// Delete user steps
	ctx.Step(`^I delete the user$`, c.iDeleteTheUser)
	ctx.Step(`^the user should be deleted successfully$`, c.theUserShouldBeDeletedSuccessfully)
	ctx.Step(`^the user should not exist in the system$`, c.theUserShouldNotExistInTheSystem)

	// List users steps
	ctx.Step(`^the following users exist:$`, c.theFollowingUsersExist)
	ctx.Step(`^I list all users$`, c.iListAllUsers)
	ctx.Step(`^I should receive a list of (\d+) users$`, c.iShouldReceiveAListOfUsers)
	ctx.Step(`^the list should include the following users:$`, c.theListShouldIncludeTheFollowingUsers)

	// Common steps
	ctx.Step(`^the user should have the following details:$`, c.theUserShouldHaveTheFollowingDetails)

	// Before and after hooks
	ctx.Before(func(ctx context.Context, sc *godog.Scenario) (context.Context, error) {
		return ctx, c.setup()
	})

	ctx.After(func(ctx context.Context, sc *godog.Scenario, err error) (context.Context, error) {
		return ctx, c.teardown()
	})
}

// setup sets up the test environment
func (c *UserContext) setup() error {
	// Initialize dependency injection container with in-memory repository
	container := di.NewContainer(nil, true) // Use in-memory repository for tests

	// Get the repository from the container
	c.userRepo = container.UserRepository
	c.memoryRepo = c.userRepo.(*memory.UserRepository)

	// Initialize router
	router := mux.NewRouter()
	container.UserHandler.RegisterRoutes(router.PathPrefix("/api/v1").Subrouter())

	// Initialize test server
	c.testServer = httptest.NewServer(router)

	return nil
}

// teardown cleans up the test environment
func (c *UserContext) teardown() error {
	if c.testServer != nil {
		c.testServer.Close()
	}

	// Clear the in-memory repository
	if c.memoryRepo != nil {
		c.memoryRepo.Clear()
	}

	return nil
}

// cleanDatabase cleans the database (now just clears the in-memory repository)
func (c *UserContext) cleanDatabase() error {
	if c.memoryRepo != nil {
		c.memoryRepo.Clear()
	}
	return nil
}

// getEnv gets an environment variable with a default value
func getEnv(key, defaultValue string) string {
	if value, exists := os.LookupEnv(key); exists {
		return value
	}
	return defaultValue
}

// Step implementations

func (c *UserContext) theSystemIsRunning() error {
	// The system is already running from the setup
	return nil
}

func (c *UserContext) theDatabaseIsClean() error {
	return c.cleanDatabase()
}

func (c *UserContext) aUserExistsWithTheFollowingDetails(table *godog.Table) error {
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least 2 rows")
	}

	// Get the first data row (skip header)
	row := table.Rows[1]
	if len(row.Cells) < 4 {
		return fmt.Errorf("row must have at least 4 cells")
	}

	// Create a user
	user := domain.NewUser(
		row.Cells[0].Value, // email
		row.Cells[1].Value, // first_name
		row.Cells[2].Value, // last_name
		row.Cells[3].Value, // role
	)
	user.ID = uuid.New().String()

	// Save the user
	if err := c.userRepo.Create(context.Background(), user); err != nil {
		return err
	}

	// Store the current user
	c.currentUser = user

	return nil
}

func (c *UserContext) iCreateAUserWithTheFollowingDetails(table *godog.Table) error {
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least 2 rows")
	}

	// Get the first data row (skip header)
	row := table.Rows[1]
	if len(row.Cells) < 4 {
		return fmt.Errorf("row must have at least 4 cells")
	}

	// Create a user
	cmd := commands.CreateUserCommand{
		Email:     row.Cells[0].Value,
		FirstName: row.Cells[1].Value,
		LastName:  row.Cells[2].Value,
		Role:      row.Cells[3].Value,
	}

	// Create the user
	container := di.NewContainer(nil, true)
	user, err := container.CreateUserHandler.Handle(context.Background(), cmd)
	if err != nil {
		c.lastError = err
		return nil
	}

	// Store the current user
	c.currentUser = user

	return nil
}

func (c *UserContext) theUserShouldBeCreatedSuccessfully() error {
	if c.lastError != nil {
		return fmt.Errorf("failed to create user: %w", c.lastError)
	}
	if c.currentUser == nil {
		return fmt.Errorf("user was not created")
	}
	return nil
}

func (c *UserContext) iGetTheUserByID() error {
	if c.currentUser == nil {
		return fmt.Errorf("no current user")
	}

	// Get the user
	query := queries.GetUserByIDQuery{
		ID: c.currentUser.ID,
	}

	container := di.NewContainer(nil, true)
	container.UserRepository = c.userRepo // Use the same repository instance
	user, err := container.GetUserByIDHandler.Handle(context.Background(), query)
	if err != nil {
		c.lastError = err
		return nil
	}

	// Store the current user
	c.currentUser = user

	return nil
}

func (c *UserContext) iShouldReceiveTheUserDetails() error {
	if c.lastError != nil {
		return fmt.Errorf("failed to get user: %w", c.lastError)
	}
	if c.currentUser == nil {
		return fmt.Errorf("user was not found")
	}
	return nil
}

func (c *UserContext) iUpdateTheUserWithTheFollowingDetails(table *godog.Table) error {
	if c.currentUser == nil {
		return fmt.Errorf("no current user")
	}

	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least 2 rows")
	}

	// Get the first data row (skip header)
	row := table.Rows[1]
	if len(row.Cells) < 4 {
		return fmt.Errorf("row must have at least 4 cells")
	}

	// Update the user
	cmd := commands.UpdateUserCommand{
		ID:        c.currentUser.ID,
		Email:     row.Cells[0].Value,
		FirstName: row.Cells[1].Value,
		LastName:  row.Cells[2].Value,
		Role:      row.Cells[3].Value,
	}

	container := di.NewContainer(nil, true)
	container.UserRepository = c.userRepo // Use the same repository instance
	user, err := container.UpdateUserHandler.Handle(context.Background(), cmd)
	if err != nil {
		c.lastError = err
		return nil
	}

	// Store the current user
	c.currentUser = user

	return nil
}

func (c *UserContext) theUserShouldBeUpdatedSuccessfully() error {
	if c.lastError != nil {
		return fmt.Errorf("failed to update user: %w", c.lastError)
	}
	if c.currentUser == nil {
		return fmt.Errorf("user was not updated")
	}
	return nil
}

func (c *UserContext) iDeleteTheUser() error {
	if c.currentUser == nil {
		return fmt.Errorf("no current user")
	}

	// Delete the user
	cmd := commands.DeleteUserCommand{
		ID: c.currentUser.ID,
	}

	container := di.NewContainer(nil, true)
	container.UserRepository = c.userRepo // Use the same repository instance
	c.lastError = container.DeleteUserHandler.Handle(context.Background(), cmd)

	return nil
}

func (c *UserContext) theUserShouldBeDeletedSuccessfully() error {
	if c.lastError != nil {
		return fmt.Errorf("failed to delete user: %w", c.lastError)
	}
	return nil
}

func (c *UserContext) theUserShouldNotExistInTheSystem() error {
	if c.currentUser == nil {
		return fmt.Errorf("no current user")
	}

	// Check if the user exists
	query := queries.GetUserByIDQuery{
		ID: c.currentUser.ID,
	}

	container := di.NewContainer(nil, true)
	container.UserRepository = c.userRepo // Use the same repository instance
	user, err := container.GetUserByIDHandler.Handle(context.Background(), query)
	if err != nil {
		return err
	}

	if user != nil {
		return fmt.Errorf("user still exists in the system")
	}

	return nil
}

func (c *UserContext) theFollowingUsersExist(table *godog.Table) error {
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least 2 rows")
	}

	// Clear the users slice
	c.users = nil

	// Skip the header row
	for i := 1; i < len(table.Rows); i++ {
		row := table.Rows[i]
		if len(row.Cells) < 4 {
			return fmt.Errorf("row must have at least 4 cells")
		}

		// Create a user
		user := domain.NewUser(
			row.Cells[0].Value, // email
			row.Cells[1].Value, // first_name
			row.Cells[2].Value, // last_name
			row.Cells[3].Value, // role
		)
		user.ID = uuid.New().String()

		// Save the user
		if err := c.userRepo.Create(context.Background(), user); err != nil {
			return err
		}

		// Add the user to the list
		c.users = append(c.users, user)
	}

	return nil
}

func (c *UserContext) iListAllUsers() error {
	// List the users
	query := queries.ListUsersQuery{}

	container := di.NewContainer(nil, true)
	container.UserRepository = c.userRepo // Use the same repository instance
	users, err := container.ListUsersHandler.Handle(context.Background(), query)
	if err != nil {
		c.lastError = err
		return nil
	}

	// Store the users
	c.users = users

	return nil
}

func (c *UserContext) iShouldReceiveAListOfUsers(count int) error {
	if c.lastError != nil {
		return fmt.Errorf("failed to list users: %w", c.lastError)
	}
	if len(c.users) != count {
		return fmt.Errorf("expected %d users, got %d", count, len(c.users))
	}
	return nil
}

func (c *UserContext) theListShouldIncludeTheFollowingUsers(table *godog.Table) error {
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least 2 rows")
	}

	// Skip the header row
	for i := 1; i < len(table.Rows); i++ {
		row := table.Rows[i]
		if len(row.Cells) < 4 {
			return fmt.Errorf("row must have at least 4 cells")
		}

		email := row.Cells[0].Value
		firstName := row.Cells[1].Value
		lastName := row.Cells[2].Value
		role := row.Cells[3].Value

		// Check if the user exists in the list
		found := false
		for _, user := range c.users {
			if user.Email == email && user.FirstName == firstName && user.LastName == lastName && user.Role == role {
				found = true
				break
			}
		}

		if !found {
			return fmt.Errorf("user with email %s not found in the list", email)
		}
	}

	return nil
}

func (c *UserContext) theUserShouldHaveTheFollowingDetails(table *godog.Table) error {
	if c.currentUser == nil {
		return fmt.Errorf("no current user")
	}

	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least 2 rows")
	}

	// Get the first data row (skip header)
	row := table.Rows[1]
	if len(row.Cells) < 5 {
		return fmt.Errorf("row must have at least 5 cells")
	}

	email := row.Cells[0].Value
	firstName := row.Cells[1].Value
	lastName := row.Cells[2].Value
	role := row.Cells[3].Value
	active := row.Cells[4].Value == "true"

	// Check the user details
	if c.currentUser.Email != email {
		return fmt.Errorf("expected email %s, got %s", email, c.currentUser.Email)
	}
	if c.currentUser.FirstName != firstName {
		return fmt.Errorf("expected first name %s, got %s", firstName, c.currentUser.FirstName)
	}
	if c.currentUser.LastName != lastName {
		return fmt.Errorf("expected last name %s, got %s", lastName, c.currentUser.LastName)
	}
	if c.currentUser.Role != role {
		return fmt.Errorf("expected role %s, got %s", role, c.currentUser.Role)
	}
	if c.currentUser.Active != active {
		return fmt.Errorf("expected active %v, got %v", active, c.currentUser.Active)
	}

	return nil
}

// TestFeatures runs the Godog tests
func TestFeatures(t *testing.T) {
	suite := godog.TestSuite{
		ScenarioInitializer: func(s *godog.ScenarioContext) {
			userContext := NewUserContext()
			userContext.InitializeScenario(s)
		},
		Options: &godog.Options{
			Format:   "pretty",
			Paths:    []string{"features"},
			TestingT: t,
		},
	}

	if suite.Run() != 0 {
		t.Fatal("non-zero status returned, failed to run feature tests")
	}
}

// Main function for running the tests
func main() {
	status := godog.TestSuite{
		Name: "User Management",
		ScenarioInitializer: func(s *godog.ScenarioContext) {
			userContext := NewUserContext()
			userContext.InitializeScenario(s)
		},
		Options: &godog.Options{
			Format: "pretty",
			Paths:  []string{"features"},
			Output: os.Stdout,
		},
	}.Run()

	os.Exit(status)
}
