package steps

import (
	"context"
	"database/sql"
	"fmt"
	"os"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/adapters/repositories"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/application/services"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/domain/entities"
	"github.com/cucumber/godog"
	"github.com/google/uuid"
	_ "github.com/lib/pq"
)

// CustomerTestContext holds the test context for customer operations
type CustomerTestContext struct {
	db             *sql.DB
	customerUUID   uuid.UUID
	customerData   map[string]string
	customerList   []*entities.Customer
	customerResult *entities.Customer
	customerService *services.CustomerService
	err            error
}

// InitializeTestSuite initializes the test suite
func InitializeTestSuite(ctx *godog.TestSuiteContext) {
	// Set up any suite-level initialization
}

// InitializeScenario initializes the test scenario
func InitializeScenario(ctx *godog.ScenarioContext) {
	testCtx := &CustomerTestContext{
		customerData: make(map[string]string),
	}

	// Connect to the test database
	dbURL := os.Getenv("TEST_DB_URL")
	if dbURL == "" {
		dbURL = "postgres://postgres:password@localhost:5432/customer_service_test?sslmode=disable"
	}

	var err error
	testCtx.db, err = sql.Open("postgres", dbURL)
	if err != nil {
		panic(fmt.Sprintf("Failed to connect to database: %v", err))
	}

	// Initialize repositories and services
	customerRepo := repositories.NewCustomerRepository(testCtx.db)
	testCtx.customerService = services.NewCustomerService(customerRepo)

	// Register step definitions
	ctx.Step(`^I have a valid customer UUID$`, testCtx.iHaveAValidCustomerUUID)
	ctx.Step(`^I add a customer with the following details:$`, testCtx.iAddACustomerWithTheFollowingDetails)
	ctx.Step(`^the customer should be saved successfully$`, testCtx.theCustomerShouldBeSavedSuccessfully)
	ctx.Step(`^I have a customer with UUID "([^"]*)" in the system$`, testCtx.iHaveACustomerWithUUIDInTheSystem)
	ctx.Step(`^I request the customer with UUID "([^"]*)"$`, testCtx.iRequestTheCustomerWithUUID)
	ctx.Step(`^I should receive the customer details:$`, testCtx.iShouldReceiveTheCustomerDetails)
	ctx.Step(`^I update the customer with the following details:$`, testCtx.iUpdateTheCustomerWithTheFollowingDetails)
	ctx.Step(`^the customer should be updated successfully$`, testCtx.theCustomerShouldBeUpdatedSuccessfully)
	ctx.Step(`^when I request the customer with UUID "([^"]*)"$`, testCtx.iRequestTheCustomerWithUUID)
	ctx.Step(`^I have the following customers in the system:$`, testCtx.iHaveTheFollowingCustomersInTheSystem)
	ctx.Step(`^I request a list of all customers$`, testCtx.iRequestAListOfAllCustomers)
	ctx.Step(`^I should receive a list containing (\d+) customers$`, testCtx.iShouldReceiveAListContainingCustomers)

	// Clean up after each scenario
	ctx.After(func(ctx context.Context, sc *godog.Scenario, err error) (context.Context, error) {
		// Clean up the database
		_, err = testCtx.db.Exec("DELETE FROM customers")
		if err != nil {
			return ctx, fmt.Errorf("failed to clean up database: %w", err)
		}

		// Close the database connection
		if testCtx.db != nil {
			testCtx.db.Close()
		}

		return ctx, nil
	})
}

// Step definitions

func (ctx *CustomerTestContext) iHaveAValidCustomerUUID() error {
	ctx.customerUUID = uuid.MustParse("550e8400-e29b-41d4-a716-446655440000")
	return nil
}

func (ctx *CustomerTestContext) iAddACustomerWithTheFollowingDetails(table *godog.Table) error {
	// Extract customer data from table
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least one data row")
	}

	headers := table.Rows[0].Cells
	data := table.Rows[1].Cells

	for i, header := range headers {
		ctx.customerData[header.Value] = data[i].Value
	}

	// Parse UUID
	var err error
	ctx.customerUUID, err = uuid.Parse(ctx.customerData["uuid"])
	if err != nil {
		return fmt.Errorf("invalid UUID: %w", err)
	}

	// Create customer entity
	now := time.Now().UTC()
	customer := &entities.Customer{
		UUID:         ctx.customerUUID,
		FirstName:    ctx.customerData["firstName"],
		LastName:     ctx.customerData["lastName"],
		ContactEmail: ctx.customerData["contactEmail"],
		ContactPhone: ctx.customerData["contactPhone"],
		CreatedAt:    now,
		UpdatedAt:    now,
	}

	// Add customer
	err = ctx.customerService.AddCustomer(context.Background(), customer)
	if err != nil {
		ctx.err = err
		return nil // We'll check the error in the next step
	}

	return nil
}

func (ctx *CustomerTestContext) theCustomerShouldBeSavedSuccessfully() error {
	if ctx.err != nil {
		return fmt.Errorf("failed to save customer: %w", ctx.err)
	}

	// Verify customer was saved
	var count int
	err := ctx.db.QueryRow("SELECT COUNT(*) FROM customers WHERE uuid = $1", ctx.customerUUID).Scan(&count)
	if err != nil {
		return fmt.Errorf("failed to query customer count: %w", err)
	}

	if count != 1 {
		return fmt.Errorf("expected 1 customer, got %d", count)
	}

	return nil
}

func (ctx *CustomerTestContext) iHaveACustomerWithUUIDInTheSystem(uuidStr string) error {
	// Parse UUID
	customerUUID, err := uuid.Parse(uuidStr)
	if err != nil {
		return fmt.Errorf("invalid UUID: %w", err)
	}

	// Check if customer already exists
	var count int
	err = ctx.db.QueryRow("SELECT COUNT(*) FROM customers WHERE uuid = $1", customerUUID).Scan(&count)
	if err != nil {
		return fmt.Errorf("failed to query customer count: %w", err)
	}

	if count == 0 {
		// Insert customer
		now := time.Now().UTC()
		_, err = ctx.db.Exec(
			"INSERT INTO customers (uuid, first_name, last_name, contact_email, contact_phone, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6, $7)",
			customerUUID,
			"John",
			"Doe",
			"john.doe@example.com",
			"+1234567890",
			now,
			now,
		)
		if err != nil {
			return fmt.Errorf("failed to insert customer: %w", err)
		}
	}

	return nil
}

func (ctx *CustomerTestContext) iRequestTheCustomerWithUUID(uuidStr string) error {
	// Parse UUID
	customerUUID, err := uuid.Parse(uuidStr)
	if err != nil {
		return fmt.Errorf("invalid UUID: %w", err)
	}

	// Get customer
	customer, err := ctx.customerService.GetCustomer(context.Background(), customerUUID)
	if err != nil {
		ctx.err = err
		return nil // We'll check the error in the next step
	}

	ctx.customerResult = customer
	return nil
}

func (ctx *CustomerTestContext) iShouldReceiveTheCustomerDetails(table *godog.Table) error {
	if ctx.err != nil {
		return fmt.Errorf("failed to get customer: %w", ctx.err)
	}

	if ctx.customerResult == nil {
		return fmt.Errorf("customer result is nil")
	}

	// Extract expected customer data from table
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least one data row")
	}

	headers := table.Rows[0].Cells
	data := table.Rows[1].Cells

	expectedData := make(map[string]string)
	for i, header := range headers {
		expectedData[header.Value] = data[i].Value
	}

	// Verify customer details
	if ctx.customerResult.UUID.String() != expectedData["uuid"] {
		return fmt.Errorf("expected UUID %s, got %s", expectedData["uuid"], ctx.customerResult.UUID.String())
	}
	if ctx.customerResult.FirstName != expectedData["firstName"] {
		return fmt.Errorf("expected first name %s, got %s", expectedData["firstName"], ctx.customerResult.FirstName)
	}
	if ctx.customerResult.LastName != expectedData["lastName"] {
		return fmt.Errorf("expected last name %s, got %s", expectedData["lastName"], ctx.customerResult.LastName)
	}
	if ctx.customerResult.ContactEmail != expectedData["contactEmail"] {
		return fmt.Errorf("expected contact email %s, got %s", expectedData["contactEmail"], ctx.customerResult.ContactEmail)
	}
	if ctx.customerResult.ContactPhone != expectedData["contactPhone"] {
		return fmt.Errorf("expected contact phone %s, got %s", expectedData["contactPhone"], ctx.customerResult.ContactPhone)
	}

	return nil
}

func (ctx *CustomerTestContext) iUpdateTheCustomerWithTheFollowingDetails(table *godog.Table) error {
	// Extract customer data from table
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least one data row")
	}

	headers := table.Rows[0].Cells
	data := table.Rows[1].Cells

	for i, header := range headers {
		ctx.customerData[header.Value] = data[i].Value
	}

	// Parse UUID
	var err error
	ctx.customerUUID, err = uuid.Parse(ctx.customerData["uuid"])
	if err != nil {
		return fmt.Errorf("invalid UUID: %w", err)
	}

	// Create customer entity
	now := time.Now().UTC()
	customer := &entities.Customer{
		UUID:         ctx.customerUUID,
		FirstName:    ctx.customerData["firstName"],
		LastName:     ctx.customerData["lastName"],
		ContactEmail: ctx.customerData["contactEmail"],
		ContactPhone: ctx.customerData["contactPhone"],
		CreatedAt:    now,
		UpdatedAt:    now,
	}

	// Update customer
	err = ctx.customerService.UpdateCustomer(context.Background(), customer)
	if err != nil {
		ctx.err = err
		return nil // We'll check the error in the next step
	}

	return nil
}

func (ctx *CustomerTestContext) theCustomerShouldBeUpdatedSuccessfully() error {
	if ctx.err != nil {
		return fmt.Errorf("failed to update customer: %w", ctx.err)
	}

	// Verify customer was updated
	var firstName, lastName, contactEmail, contactPhone string
	err := ctx.db.QueryRow(
		"SELECT first_name, last_name, contact_email, contact_phone FROM customers WHERE uuid = $1",
		ctx.customerUUID,
	).Scan(&firstName, &lastName, &contactEmail, &contactPhone)
	if err != nil {
		return fmt.Errorf("failed to query customer: %w", err)
	}

	if firstName != ctx.customerData["firstName"] {
		return fmt.Errorf("expected first name %s, got %s", ctx.customerData["firstName"], firstName)
	}
	if lastName != ctx.customerData["lastName"] {
		return fmt.Errorf("expected last name %s, got %s", ctx.customerData["lastName"], lastName)
	}
	if contactEmail != ctx.customerData["contactEmail"] {
		return fmt.Errorf("expected contact email %s, got %s", ctx.customerData["contactEmail"], contactEmail)
	}
	if contactPhone != ctx.customerData["contactPhone"] {
		return fmt.Errorf("expected contact phone %s, got %s", ctx.customerData["contactPhone"], contactPhone)
	}

	return nil
}

func (ctx *CustomerTestContext) iHaveTheFollowingCustomersInTheSystem(table *godog.Table) error {
	// Extract customer data from table
	if len(table.Rows) < 2 {
		return fmt.Errorf("table must have at least one data row")
	}

	headers := table.Rows[0].Cells
	for i := 1; i < len(table.Rows); i++ {
		data := table.Rows[i].Cells
		customerData := make(map[string]string)
		for j, header := range headers {
			customerData[header.Value] = data[j].Value
		}

		// Parse UUID
		customerUUID, err := uuid.Parse(customerData["uuid"])
		if err != nil {
			return fmt.Errorf("invalid UUID: %w", err)
		}

		// Insert customer
		now := time.Now().UTC()
		_, err = ctx.db.Exec(
			"INSERT INTO customers (uuid, first_name, last_name, contact_email, contact_phone, created_at, updated_at) VALUES ($1, $2, $3, $4, $5, $6, $7)",
			customerUUID,
			customerData["firstName"],
			customerData["lastName"],
			customerData["contactEmail"],
			customerData["contactPhone"],
			now,
			now,
		)
		if err != nil {
			return fmt.Errorf("failed to insert customer: %w", err)
		}
	}

	return nil
}

func (ctx *CustomerTestContext) iRequestAListOfAllCustomers() error {
	// List customers
	customers, err := ctx.customerService.ListCustomers(context.Background())
	if err != nil {
		ctx.err = err
		return nil // We'll check the error in the next step
	}

	ctx.customerList = customers
	return nil
}

func (ctx *CustomerTestContext) iShouldReceiveAListContainingCustomers(count int) error {
	if ctx.err != nil {
		return fmt.Errorf("failed to list customers: %w", ctx.err)
	}

	if len(ctx.customerList) != count {
		return fmt.Errorf("expected %d customers, got %d", count, len(ctx.customerList))
	}

	return nil
}
