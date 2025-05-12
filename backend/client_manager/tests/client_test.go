package tests

import (
	"fmt"
	"os"
	"testing"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/tests/steps"
	"github.com/cucumber/godog"
)

func TestFeatures(t *testing.T) {
	// Skip tests if explicitly requested
	if os.Getenv("SKIP_DB_TESTS") == "true" {
		t.Skip("Skipping tests that require a database")
	}

	// Use testcontainers for PostgreSQL and Temporal
	fmt.Println("Setting up test containers for PostgreSQL and Temporal...")
	testContainers, err := SetupTestContainers()
	if err != nil {
		t.Fatalf("Failed to set up test containers: %v", err)
	}
	defer func() {
		fmt.Println("Cleaning up test containers...")
		if err := testContainers.Cleanup(); err != nil {
			fmt.Printf("Warning: Failed to clean up test containers: %v\n", err)
		}
	}()

	// Set environment variables for tests
	os.Setenv("TEST_DB_URL", testContainers.PostgresURI)

	fmt.Println("PostgreSQL URI:", testContainers.PostgresURI)

	// Run API tests
	fmt.Println("Running API tests...")
	apiSuite := godog.TestSuite{
		ScenarioInitializer: steps.InitializeScenario,
		Options: &godog.Options{
			Format:   "pretty",
			Paths:    []string{"features/client_management.feature"},
			TestingT: t,
		},
	}

	if apiSuite.Run() != 0 {
		t.Fatal("non-zero status returned, failed to run API feature tests")
	}

	// Run Temporal workflow tests
	fmt.Println("Running Temporal workflow tests...")
	temporalSuite := godog.TestSuite{
		ScenarioInitializer: steps.InitializeTemporalScenario,
		Options: &godog.Options{
			Format:   "pretty",
			Paths:    []string{"features/temporal_workflows.feature"},
			TestingT: t,
		},
	}

	if temporalSuite.Run() != 0 {
		t.Fatal("non-zero status returned, failed to run Temporal workflow tests")
	}
}
