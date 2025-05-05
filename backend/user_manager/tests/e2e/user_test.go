package e2e

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"testing"

	"github.com/cucumber/godog"
)

// APIFeature holds the state for the API tests
type APIFeature struct {
	client      *http.Client
	baseURL     string
	response    *http.Response
	responseBody []byte
	userID      string
	authToken   string
}

// NewAPIFeature creates a new APIFeature
func NewAPIFeature() *APIFeature {
	baseURL := os.Getenv("API_BASE_URL")
	if baseURL == "" {
		baseURL = "http://localhost:8082"
	}

	return &APIFeature{
		client:  &http.Client{},
		baseURL: baseURL,
	}
}

// theSystemIsRunning checks if the system is running
func (f *APIFeature) theSystemIsRunning() error {
	resp, err := f.client.Get(fmt.Sprintf("%s/health", f.baseURL))
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("system is not running, got status code: %d", resp.StatusCode)
	}

	return nil
}

// iAmAuthenticatedAsAnAdministrator authenticates as an administrator
func (f *APIFeature) iAmAuthenticatedAsAnAdministrator() error {
	// In a real implementation, this would authenticate with Keycloak
	// For testing purposes, we'll just set a mock token
	f.authToken = "mock-admin-token"
	return nil
}

// InitializeScenario initializes the scenario
func InitializeScenario(ctx *godog.ScenarioContext) {
	api := NewAPIFeature()

	ctx.Step(`^the system is running$`, api.theSystemIsRunning)
	ctx.Step(`^I am authenticated as an administrator$`, api.iAmAuthenticatedAsAnAdministrator)
	
	// Add more step definitions here for the Gherkin scenarios
	// For example:
	// ctx.Step(`^I create a user with the following details:$`, api.iCreateAUserWithTheFollowingDetails)
	// ctx.Step(`^the user should be saved in the database$`, api.theUserShouldBeSavedInTheDatabase)
	// etc.
}

func TestFeatures(t *testing.T) {
	// Skip if not running E2E tests
	if os.Getenv("E2E_TESTS") != "true" {
		t.Skip("Skipping E2E test. Set E2E_TESTS=true to run")
	}

	suite := godog.TestSuite{
		ScenarioInitializer: InitializeScenario,
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

// This is just a placeholder for the main function to run the tests directly
func ExampleRunTests() {
	status := godog.TestSuite{
		ScenarioInitializer: InitializeScenario,
		Options: &godog.Options{
			Format: "pretty",
			Paths:  []string{"features"},
		},
	}.Run()

	os.Exit(status)
}

// Example of how to run the tests from the command line:
// go test -v
// or with specific tags:
// go test -v --godog.tags=@users
