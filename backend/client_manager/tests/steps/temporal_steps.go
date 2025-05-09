package steps

import (
	"context"
	"database/sql"
	"fmt"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/cucumber/godog"
	"github.com/google/uuid"
	"go.temporal.io/sdk/client"
)

// TemporalTestContext holds the test context for Temporal workflows
type TemporalTestContext struct {
	temporalClient client.Client
	workflowID     string
	clientUUID     uuid.UUID
	clientData     map[string]string
	result         interface{}
	db             *sql.DB
}

// InitializeTemporalScenario initializes the test scenario for Temporal workflows
func InitializeTemporalScenario(ctx *godog.ScenarioContext) {
	testCtx := &TemporalTestContext{
		clientData: make(map[string]string),
	}

	// Set up database connection for tests
	var err error
	testCtx.db, err = sql.Open("postgres", "postgres://postgres:password@localhost:5432/client_manager_test?sslmode=disable")
	if err != nil {
		panic(fmt.Sprintf("Failed to connect to test database: %v", err))
	}

	// Define step definitions
	ctx.Before(func(ctx context.Context, sc *godog.Scenario) (context.Context, error) {
		// Reset test context before each scenario
		testCtx.workflowID = ""
		testCtx.clientUUID = uuid.Nil
		testCtx.clientData = make(map[string]string)
		testCtx.result = nil

		// Clean up database before each test
		_, err := testCtx.db.Exec("DELETE FROM clients")
		if err != nil {
			return ctx, fmt.Errorf("failed to clean up database: %w", err)
		}

		return ctx, nil
	})

	ctx.After(func(ctx context.Context, sc *godog.Scenario, err error) (context.Context, error) {
		// Clean up after each test
		if testCtx.db != nil {
			_, dbErr := testCtx.db.Exec("DELETE FROM clients")
			if dbErr != nil {
				return ctx, fmt.Errorf("failed to clean up database: %w", dbErr)
			}
		}

		// Close Temporal client
		if testCtx.temporalClient != nil {
			testCtx.temporalClient.Close()
		}

		return ctx, nil
	})

	ctx.Step(`^I have a Temporal client connected to "([^"]*)"$`, testCtx.iHaveATemporalClientConnectedTo)
	ctx.Step(`^I execute the AddClient workflow with the following details:$`, testCtx.iExecuteTheAddClientWorkflowWithTheFollowingDetails)
	ctx.Step(`^I execute the GetClient workflow with UUID "([^"]*)"$`, testCtx.iExecuteTheGetClientWorkflowWithUUID)
	ctx.Step(`^the workflow should complete successfully$`, testCtx.theWorkflowShouldCompleteSuccessfully)
	ctx.Step(`^the client should be saved in the database$`, testCtx.theClientShouldBeSavedInTheDatabase)
	ctx.Step(`^I should receive the client details$`, testCtx.iShouldReceiveTheClientDetails)
	ctx.Step(`^I should receive an empty client$`, testCtx.iShouldReceiveAnEmptyClient)
	ctx.Step(`^a client exists with UUID "([^"]*)"$`, testCtx.aClientExistsWithUUID)
	ctx.Step(`^no client exists with UUID "([^"]*)"$`, testCtx.noClientExistsWithUUID)
}

// Step implementations
func (ctx *TemporalTestContext) iHaveATemporalClientConnectedTo(namespace string) error {
	var err error
	ctx.temporalClient, err = client.Dial(client.Options{
		HostPort:  "localhost:7233",
		Namespace: namespace,
	})
	if err != nil {
		return fmt.Errorf("failed to create Temporal client: %w", err)
	}
	return nil
}

func (ctx *TemporalTestContext) iExecuteTheAddClientWorkflowWithTheFollowingDetails(table *godog.Table) error {
	// Extract client data from table
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least one data row")
	}

	headers := table.Rows[0].Cells
	data := table.Rows[1].Cells

	for i, header := range headers {
		ctx.clientData[header.Value] = data[i].Value
	}

	// Parse UUID
	var err error
	ctx.clientUUID, err = uuid.Parse(ctx.clientData["uuid"])
	if err != nil {
		return fmt.Errorf("invalid UUID: %w", err)
	}

	// Create client entity
	client := &entities.Client{
		UUID:         ctx.clientUUID,
		FirstName:    ctx.clientData["firstName"],
		LastName:     ctx.clientData["lastName"],
		ContactEmail: ctx.clientData["contactEmail"],
		PhoneNumber:  ctx.clientData["phoneNumber"],
	}

	// Generate workflow ID
	ctx.workflowID = fmt.Sprintf("test-add-client-%s", ctx.clientUUID.String())

	// Execute workflow
	workflowOptions := client.StartWorkflowOptions{
		ID:        ctx.workflowID,
		TaskQueue: "client-manager-task-queue",
	}

	run, err := ctx.temporalClient.ExecuteWorkflow(context.Background(), workflowOptions, "AddClientWorkflow", client)
	if err != nil {
		return fmt.Errorf("failed to execute workflow: %w", err)
	}

	// Wait for workflow completion
	var result entities.Client
	err = run.Get(context.Background(), &result)
	if err != nil {
		return fmt.Errorf("workflow execution failed: %w", err)
	}

	ctx.result = &result
	return nil
}

func (ctx *TemporalTestContext) iExecuteTheGetClientWorkflowWithUUID(uuidStr string) error {
	// Parse UUID
	var err error
	ctx.clientUUID, err = uuid.Parse(uuidStr)
	if err != nil {
		return fmt.Errorf("invalid UUID: %w", err)
	}

	// Generate workflow ID
	ctx.workflowID = fmt.Sprintf("test-get-client-%s", ctx.clientUUID.String())

	// Execute workflow
	workflowOptions := client.StartWorkflowOptions{
		ID:        ctx.workflowID,
		TaskQueue: "client-manager-task-queue",
	}

	run, err := ctx.temporalClient.ExecuteWorkflow(context.Background(), workflowOptions, "GetClientWorkflow", ctx.clientUUID)
	if err != nil {
		return fmt.Errorf("failed to execute workflow: %w", err)
	}

	// Wait for workflow completion
	var result entities.Client
	err = run.Get(context.Background(), &result)
	if err != nil {
		return fmt.Errorf("workflow execution failed: %w", err)
	}

	ctx.result = &result
	return nil
}

func (ctx *TemporalTestContext) theWorkflowShouldCompleteSuccessfully() error {
	// Check if workflow completed
	if ctx.result == nil {
		return fmt.Errorf("workflow did not complete")
	}
	return nil
}

func (ctx *TemporalTestContext) theClientShouldBeSavedInTheDatabase() error {
	// Check if client was saved in the database
	var count int
	err := ctx.db.QueryRow("SELECT COUNT(*) FROM clients WHERE uuid = $1", ctx.clientUUID).Scan(&count)
	if err != nil {
		return fmt.Errorf("failed to query database: %w", err)
	}

	if count != 1 {
		return fmt.Errorf("expected 1 client record but found %d", count)
	}
	return nil
}

func (ctx *TemporalTestContext) iShouldReceiveTheClientDetails() error {
	// Check if result is a client
	client, ok := ctx.result.(*entities.Client)
	if !ok {
		return fmt.Errorf("result is not a client")
	}

	// Check if client has the expected UUID
	if client.UUID != ctx.clientUUID {
		return fmt.Errorf("expected client UUID %s but got %s", ctx.clientUUID, client.UUID)
	}

	// Check if client has data
	if client.IsEmpty() {
		return fmt.Errorf("client is empty")
	}

	return nil
}

func (ctx *TemporalTestContext) iShouldReceiveAnEmptyClient() error {
	// Check if result is a client
	client, ok := ctx.result.(*entities.Client)
	if !ok {
		return fmt.Errorf("result is not a client")
	}

	// Check if client has the expected UUID
	if client.UUID != ctx.clientUUID {
		return fmt.Errorf("expected client UUID %s but got %s", ctx.clientUUID, client.UUID)
	}

	// Check if client is empty
	if !client.IsEmpty() {
		return fmt.Errorf("client is not empty: %+v", client)
	}

	return nil
}

func (ctx *TemporalTestContext) aClientExistsWithUUID(uuidStr string) error {
	// Parse UUID
	var err error
	ctx.clientUUID, err = uuid.Parse(uuidStr)
	if err != nil {
		return fmt.Errorf("invalid UUID: %w", err)
	}

	// Insert client into database
	_, err = ctx.db.Exec(
		"INSERT INTO clients (uuid, first_name, last_name, contact_email, phone_number) VALUES ($1, $2, $3, $4, $5)",
		ctx.clientUUID,
		"Test",
		"User",
		"test.user@example.com",
		"+9876543210",
	)
	if err != nil {
		return fmt.Errorf("failed to insert client: %w", err)
	}

	return nil
}

func (ctx *TemporalTestContext) noClientExistsWithUUID(uuidStr string) error {
	// Parse UUID
	var err error
	ctx.clientUUID, err = uuid.Parse(uuidStr)
	if err != nil {
		return fmt.Errorf("invalid UUID: %w", err)
	}

	// Delete client from database if it exists
	_, err = ctx.db.Exec("DELETE FROM clients WHERE uuid = $1", ctx.clientUUID)
	if err != nil {
		return fmt.Errorf("failed to delete client: %w", err)
	}

	return nil
}
