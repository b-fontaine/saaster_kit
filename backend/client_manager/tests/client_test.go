package tests

import (
	"testing"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/tests/steps"
	"github.com/cucumber/godog"
)

func TestFeatures(t *testing.T) {
	// Run API tests
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
