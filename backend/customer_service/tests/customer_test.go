package tests

import (
	"fmt"
	"os"
	"testing"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/tests/steps"
	"github.com/cucumber/godog"
)

func TestCustomerFeatures(t *testing.T) {
	// Skip tests if SKIP_DB_TESTS is set
	if os.Getenv("SKIP_DB_TESTS") == "true" {
		t.Skip("Skipping database tests")
	}

	// Set up test containers
	testContainers, err := SetupTestContainers()
	if err != nil {
		t.Fatalf("Failed to set up test containers: %v", err)
	}
	defer testContainers.Cleanup()

	// Set environment variables for tests
	os.Setenv("TEST_DB_URL", testContainers.PostgresURI)

	fmt.Println("PostgreSQL URI:", testContainers.PostgresURI)

	// Run Godog tests
	opts := godog.Options{
		Format:      "pretty",
		Paths:       []string{"features"},
		Randomize:   0,
		Concurrency: 1,
	}

	suite := godog.TestSuite{
		Name:                 "Customer Service Tests",
		ScenarioInitializer:  steps.InitializeScenario,
		TestSuiteInitializer: steps.InitializeTestSuite,
		Options:              &opts,
	}

	if suite.Run() != 0 {
		t.Fatal("Non-zero exit code from Godog tests")
	}
}
