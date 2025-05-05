package integration

import (
	"context"
	"database/sql"
	"os"
	"testing"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/config"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/models"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/repository"
	_ "github.com/lib/pq"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

// setupTestDB sets up a test database connection
func setupTestDB(t *testing.T) *sql.DB {
	// Use environment variables or default to test values
	dbConfig := config.DatabaseConfig{
		Host:     getEnvOrDefault("TEST_DB_HOST", "localhost"),
		Port:     getEnvOrDefault("TEST_DB_PORT", "5432"),
		User:     getEnvOrDefault("TEST_DB_USER", "user_manager"),
		Password: getEnvOrDefault("TEST_DB_PASSWORD", "password"),
		DBName:   getEnvOrDefault("TEST_DB_NAME", "user_db_test"),
		SSLMode:  "disable",
	}

	// Connect to the database
	db, err := repository.NewPostgresDB(dbConfig)
	require.NoError(t, err, "Failed to connect to test database")

	// Run migrations to set up the schema
	err = repository.RunMigrations(db)
	require.NoError(t, err, "Failed to run migrations")

	return db
}

// getEnvOrDefault gets an environment variable or returns a default value
func getEnvOrDefault(key, defaultValue string) string {
	if value, exists := os.LookupEnv(key); exists {
		return value
	}
	return defaultValue
}

// cleanupTestDB cleans up the test database
func cleanupTestDB(t *testing.T, db *sql.DB) {
	_, err := db.Exec("DELETE FROM users")
	require.NoError(t, err, "Failed to clean up test database")
}

// TestUserRepository_Integration tests the user repository with a real database
func TestUserRepository_Integration(t *testing.T) {
	// Skip if not running integration tests
	if os.Getenv("INTEGRATION_TESTS") != "true" {
		t.Skip("Skipping integration test. Set INTEGRATION_TESTS=true to run")
	}

	// Set up test database
	db := setupTestDB(t)
	defer db.Close()
	defer cleanupTestDB(t, db)

	// Create repository
	userRepo := repository.NewUserRepository(db)

	// Test creating a user
	t.Run("CreateUser", func(t *testing.T) {
		// Create a user request
		req := models.CreateUserRequest{
			Email:     "integration-test@example.com",
			FirstName: "Integration",
			LastName:  "Test",
			Role:      "tester",
		}

		// Create a user
		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()

		user, err := userRepo.CreateUser(ctx, req)
		require.NoError(t, err, "Failed to create user")
		assert.NotEmpty(t, user.ID, "User ID should not be empty")
		assert.Equal(t, req.Email, user.Email)
		assert.Equal(t, req.FirstName, user.FirstName)
		assert.Equal(t, req.LastName, user.LastName)
		assert.Equal(t, req.Role, user.Role)
		assert.True(t, user.Active)

		// Test retrieving the user
		retrievedUser, err := userRepo.GetUserByID(ctx, user.ID)
		require.NoError(t, err, "Failed to retrieve user")
		assert.Equal(t, user.ID, retrievedUser.ID)
		assert.Equal(t, user.Email, retrievedUser.Email)
	})

	// Test listing users
	t.Run("ListUsers", func(t *testing.T) {
		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()

		users, err := userRepo.ListUsers(ctx)
		require.NoError(t, err, "Failed to list users")
		assert.GreaterOrEqual(t, len(users), 1, "Should have at least one user")
	})
}
