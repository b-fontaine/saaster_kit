package steps

import (
	"bytes"
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"net/http/httptest"
	"os"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/adapters/handlers"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/adapters/repositories"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/application/services"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/cucumber/godog"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
	_ "github.com/lib/pq"
	"github.com/stretchr/testify/assert"
)

// ClientTestContext holds the test context
type ClientTestContext struct {
	router       *gin.Engine
	response     *httptest.ResponseRecorder
	clientUUID   uuid.UUID
	clientData   map[string]string
	responseBody []byte
	db           *sql.DB
}

// InitializeScenario initializes the test scenario
func InitializeScenario(ctx *godog.ScenarioContext) {
	testCtx := &ClientTestContext{
		router:     gin.Default(),
		clientData: make(map[string]string),
	}

	// Set up database connection for tests
	dbURL := os.Getenv("TEST_DB_URL")
	if dbURL == "" {
		dbURL = "postgres://postgres:password@localhost:5432/client_manager_test?sslmode=disable"
	}

	var err error
	testCtx.db, err = sql.Open("postgres", dbURL)
	if err != nil {
		panic(fmt.Sprintf("Failed to connect to test database: %v", err))
	}

	// Set up API routes for testing
	clientRepo := repositories.NewClientRepository(testCtx.db)
	clientService := services.NewClientService(clientRepo)
	clientHandler := handlers.NewClientHandler(clientService)

	api := testCtx.router.Group("/api/v1")
	clients := api.Group("/clients")
	
	// Mock auth middleware for testing
	clients.Use(func(c *gin.Context) {
		c.Set("userID", testCtx.clientUUID.String())
		c.Next()
	})
	
	clients.POST("", clientHandler.AddClient)
	clients.GET("", clientHandler.GetClient)

	// Define step definitions
	ctx.Before(func(ctx context.Context, sc *godog.Scenario) (context.Context, error) {
		// Reset test context before each scenario
		testCtx.response = httptest.NewRecorder()
		testCtx.clientData = make(map[string]string)
		testCtx.responseBody = nil
		
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
		return ctx, nil
	})

	ctx.Step(`^I am authenticated with UUID "([^"]*)"$`, testCtx.iAmAuthenticatedWithUUID)
	ctx.Step(`^I add a client with the following details:$`, testCtx.iAddAClientWithTheFollowingDetails)
	ctx.Step(`^the client should be saved successfully$`, testCtx.theClientShouldBeSavedSuccessfully)
	ctx.Step(`^I should receive the client details in the response$`, testCtx.iShouldReceiveTheClientDetailsInTheResponse)
	ctx.Step(`^I have a client record in the system$`, testCtx.iHaveAClientRecordInTheSystem)
	ctx.Step(`^I do not have a client record in the system$`, testCtx.iDoNotHaveAClientRecordInTheSystem)
	ctx.Step(`^I request my client information$`, testCtx.iRequestMyClientInformation)
	ctx.Step(`^I should receive my client details$`, testCtx.iShouldReceiveMyClientDetails)
	ctx.Step(`^I should receive an empty client with my UUID$`, testCtx.iShouldReceiveAnEmptyClientWithMyUUID)
}

// Step implementations
func (ctx *ClientTestContext) iAmAuthenticatedWithUUID(uuidStr string) error {
	var err error
	ctx.clientUUID, err = uuid.Parse(uuidStr)
	if err != nil {
		return fmt.Errorf("invalid UUID: %w", err)
	}
	return nil
}

func (ctx *ClientTestContext) iAddAClientWithTheFollowingDetails(table *godog.Table) error {
	// Extract client data from table
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least one data row")
	}
	
	headers := table.Rows[0].Cells
	data := table.Rows[1].Cells
	
	for i, header := range headers {
		ctx.clientData[header.Value] = data[i].Value
	}
	
	// Create request body
	requestBody, err := json.Marshal(map[string]string{
		"firstName":    ctx.clientData["firstName"],
		"lastName":     ctx.clientData["lastName"],
		"contactEmail": ctx.clientData["contactEmail"],
		"phoneNumber":  ctx.clientData["phoneNumber"],
	})
	if err != nil {
		return fmt.Errorf("failed to marshal request body: %w", err)
	}
	
	// Create request
	req, err := http.NewRequest("POST", "/api/v1/clients", bytes.NewBuffer(requestBody))
	if err != nil {
		return fmt.Errorf("failed to create request: %w", err)
	}
	req.Header.Set("Content-Type", "application/json")
	
	// Perform request
	ctx.router.ServeHTTP(ctx.response, req)
	ctx.responseBody = ctx.response.Body.Bytes()
	
	return nil
}

func (ctx *ClientTestContext) theClientShouldBeSavedSuccessfully() error {
	if ctx.response.Code != http.StatusOK {
		return fmt.Errorf("expected status code %d but got %d: %s", 
			http.StatusOK, ctx.response.Code, ctx.response.Body.String())
	}
	
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

func (ctx *ClientTestContext) iShouldReceiveTheClientDetailsInTheResponse() error {
	var client entities.Client
	if err := json.Unmarshal(ctx.responseBody, &client); err != nil {
		return fmt.Errorf("failed to unmarshal response: %w", err)
	}
	
	// Verify client details
	if client.UUID != ctx.clientUUID {
		return fmt.Errorf("expected UUID %s but got %s", ctx.clientUUID, client.UUID)
	}
	
	if client.FirstName != ctx.clientData["firstName"] {
		return fmt.Errorf("expected firstName %s but got %s", ctx.clientData["firstName"], client.FirstName)
	}
	
	if client.LastName != ctx.clientData["lastName"] {
		return fmt.Errorf("expected lastName %s but got %s", ctx.clientData["lastName"], client.LastName)
	}
	
	if client.ContactEmail != ctx.clientData["contactEmail"] {
		return fmt.Errorf("expected contactEmail %s but got %s", ctx.clientData["contactEmail"], client.ContactEmail)
	}
	
	if client.PhoneNumber != ctx.clientData["phoneNumber"] {
		return fmt.Errorf("expected phoneNumber %s but got %s", ctx.clientData["phoneNumber"], client.PhoneNumber)
	}
	
	return nil
}

func (ctx *ClientTestContext) iHaveAClientRecordInTheSystem() error {
	// Insert a client record
	_, err := ctx.db.Exec(
		"INSERT INTO clients (uuid, first_name, last_name, contact_email, phone_number) VALUES ($1, $2, $3, $4, $5)",
		ctx.clientUUID,
		"Test",
		"User",
		"test.user@example.com",
		"+9876543210",
	)
	
	if err != nil {
		return fmt.Errorf("failed to insert client record: %w", err)
	}
	
	return nil
}

func (ctx *ClientTestContext) iDoNotHaveAClientRecordInTheSystem() error {
	// Ensure no client record exists
	_, err := ctx.db.Exec("DELETE FROM clients WHERE uuid = $1", ctx.clientUUID)
	if err != nil {
		return fmt.Errorf("failed to delete client record: %w", err)
	}
	
	return nil
}

func (ctx *ClientTestContext) iRequestMyClientInformation() error {
	// Create request
	req, err := http.NewRequest("GET", "/api/v1/clients", nil)
	if err != nil {
		return fmt.Errorf("failed to create request: %w", err)
	}
	
	// Perform request
	ctx.router.ServeHTTP(ctx.response, req)
	ctx.responseBody = ctx.response.Body.Bytes()
	
	return nil
}

func (ctx *ClientTestContext) iShouldReceiveMyClientDetails() error {
	if ctx.response.Code != http.StatusOK {
		return fmt.Errorf("expected status code %d but got %d: %s", 
			http.StatusOK, ctx.response.Code, ctx.response.Body.String())
	}
	
	var client entities.Client
	if err := json.Unmarshal(ctx.responseBody, &client); err != nil {
		return fmt.Errorf("failed to unmarshal response: %w", err)
	}
	
	// Verify client details
	if client.UUID != ctx.clientUUID {
		return fmt.Errorf("expected UUID %s but got %s", ctx.clientUUID, client.UUID)
	}
	
	if client.FirstName != "Test" {
		return fmt.Errorf("expected firstName %s but got %s", "Test", client.FirstName)
	}
	
	if client.LastName != "User" {
		return fmt.Errorf("expected lastName %s but got %s", "User", client.LastName)
	}
	
	if client.ContactEmail != "test.user@example.com" {
		return fmt.Errorf("expected contactEmail %s but got %s", "test.user@example.com", client.ContactEmail)
	}
	
	if client.PhoneNumber != "+9876543210" {
		return fmt.Errorf("expected phoneNumber %s but got %s", "+9876543210", client.PhoneNumber)
	}
	
	return nil
}

func (ctx *ClientTestContext) iShouldReceiveAnEmptyClientWithMyUUID() error {
	if ctx.response.Code != http.StatusOK {
		return fmt.Errorf("expected status code %d but got %d: %s", 
			http.StatusOK, ctx.response.Code, ctx.response.Body.String())
	}
	
	var client entities.Client
	if err := json.Unmarshal(ctx.responseBody, &client); err != nil {
		return fmt.Errorf("failed to unmarshal response: %w", err)
	}
	
	// Verify client details
	if client.UUID != ctx.clientUUID {
		return fmt.Errorf("expected UUID %s but got %s", ctx.clientUUID, client.UUID)
	}
	
	if !client.IsEmpty() {
		return fmt.Errorf("expected empty client but got %+v", client)
	}
	
	return nil
}
