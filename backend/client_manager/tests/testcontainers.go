package tests

import (
	"context"
	"fmt"
	"time"

	"github.com/testcontainers/testcontainers-go"
	"github.com/testcontainers/testcontainers-go/modules/postgres"
	"github.com/testcontainers/testcontainers-go/wait"
)

// TestContainers holds references to all test containers
type TestContainers struct {
	PostgresContainer *postgres.PostgresContainer
	PostgresURI       string
	ctx               context.Context
}

// SetupTestContainers sets up all test containers
func SetupTestContainers() (*TestContainers, error) {
	ctx := context.Background()
	tc := &TestContainers{
		ctx: ctx,
	}

	// Start PostgreSQL container
	pgContainer, err := tc.setupPostgres(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to start PostgreSQL container: %w", err)
	}
	tc.PostgresContainer = pgContainer

	// Get PostgreSQL connection URI
	pgURI, err := tc.getPostgresURI(ctx)
	if err != nil {
		return nil, fmt.Errorf("failed to get PostgreSQL URI: %w", err)
	}
	tc.PostgresURI = pgURI

	return tc, nil
}

// setupPostgres starts a PostgreSQL container
func (tc *TestContainers) setupPostgres(ctx context.Context) (*postgres.PostgresContainer, error) {
	pgContainer, err := postgres.RunContainer(ctx,
		testcontainers.WithImage("postgres:14-alpine"),
		postgres.WithDatabase("client_manager_test"),
		postgres.WithUsername("postgres"),
		postgres.WithPassword("password"),
		testcontainers.WithWaitStrategy(
			wait.ForLog("database system is ready to accept connections").
				WithOccurrence(2).
				WithStartupTimeout(5*time.Second),
		),
	)
	if err != nil {
		return nil, err
	}

	// We'll use the container's Exec method to execute SQL directly
	_, _, err = pgContainer.Exec(ctx, []string{
		"psql",
		"-U", "postgres",
		"-d", "client_manager_test",
		"-c", `CREATE TABLE IF NOT EXISTS clients (
			uuid UUID PRIMARY KEY,
			first_name VARCHAR(255) NOT NULL,
			last_name VARCHAR(255) NOT NULL,
			contact_email VARCHAR(255) NOT NULL,
			phone_number VARCHAR(255) NOT NULL,
			created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
			updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
		)`,
	})
	if err != nil {
		return nil, err
	}

	return pgContainer, nil
}

// getPostgresURI returns the PostgreSQL connection URI
func (tc *TestContainers) getPostgresURI(ctx context.Context) (string, error) {
	// Get the connection string from the container
	connStr, err := tc.PostgresContainer.ConnectionString(ctx)
	if err != nil {
		return "", err
	}

	// Add sslmode=disable to the connection string
	connStr += "&sslmode=disable"

	return connStr, nil
}

// Cleanup stops and removes all test containers
func (tc *TestContainers) Cleanup() error {
	if tc.PostgresContainer != nil {
		if err := tc.PostgresContainer.Terminate(tc.ctx); err != nil {
			return fmt.Errorf("failed to terminate PostgreSQL container: %w", err)
		}
	}

	return nil
}
