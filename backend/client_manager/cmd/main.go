package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/adapters/handlers"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/adapters/repositories"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/adapters/temporal"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/application/services"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/workflows"
	dapr "github.com/dapr/go-sdk/client"
	"github.com/gin-gonic/gin"
	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	_ "github.com/lib/pq"
)

func main() {
	// Get environment variables
	dbHost := getEnv("DB_HOST", "localhost")
	dbPort := getEnv("DB_PORT", "5432")
	dbUser := getEnv("DB_USER", "postgres")
	dbPassword := getEnv("DB_PASSWORD", "password")
	dbName := getEnv("DB_NAME", "client_manager_db")
	serverPort := getEnv("SERVER_PORT", "8080")
	temporalAddress := getEnv("TEMPORAL_ADDRESS", "localhost:7233")
	temporalNamespace := getEnv("TEMPORAL_NAMESPACE", "client-namespace")
	temporalTaskQueue := getEnv("TEMPORAL_TASK_QUEUE", "client-manager-task-queue")

	// Connect to the database
	dbURL := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable",
		dbUser, dbPassword, dbHost, dbPort, dbName)

	db, err := sql.Open("postgres", dbURL)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer db.Close()

	// Set connection pool parameters
	db.SetMaxOpenConns(25)
	db.SetMaxIdleConns(5)
	db.SetConnMaxLifetime(5 * time.Minute)

	// Check database connection
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	if err := db.PingContext(ctx); err != nil {
		log.Fatalf("Failed to ping database: %v", err)
	}
	log.Println("Connected to database successfully")

	// Run database migrations
	if err := runMigrations(db); err != nil {
		log.Fatalf("Failed to run migrations: %v", err)
	}
	log.Println("Migrations completed successfully")

	// Initialize Dapr client
	daprClient, err := dapr.NewClient()
	if err != nil {
		log.Fatalf("Failed to create Dapr client: %v", err)
	}
	defer daprClient.Close()

	// Initialize repositories
	clientRepo := repositories.NewClientRepository(db)

	// Initialize services
	clientService := services.NewClientService(clientRepo)

	// Initialize Temporal client with retries
	var temporalClient *temporal.TemporalClient
	var temporalErr error
	for i := 0; i < 5; i++ {
		temporalClient, temporalErr = temporal.NewTemporalClient(temporalAddress, temporalNamespace, temporalTaskQueue)
		if temporalErr == nil {
			break
		}
		log.Printf("Attempt %d: Failed to create Temporal client: %v. Retrying in 5 seconds...", i+1, temporalErr)
		time.Sleep(5 * time.Second)
	}

	if temporalErr != nil {
		log.Printf("WARNING: Could not connect to Temporal after multiple attempts: %v", temporalErr)
		log.Printf("The application will start without Temporal integration")
	} else {
		defer temporalClient.Close()

		// Start Temporal worker
		workerConfig := workflows.WorkerConfig{
			TemporalAddress: temporalAddress,
			Namespace:       temporalNamespace,
			TaskQueue:       temporalTaskQueue,
			ClientService:   clientService,
		}

		_, workerErr := workflows.StartWorker(workerConfig)
		if workerErr != nil {
			log.Printf("WARNING: Failed to start Temporal worker: %v", workerErr)
			log.Printf("The application will start without Temporal worker")
		} else {
			log.Printf("Temporal worker started successfully")
		}
	}

	// Initialize handlers
	clientHandler := handlers.NewClientHandler(clientService, temporalClient)

	// Set up Gin router
	router := gin.Default()

	// Add middleware
	router.Use(gin.Recovery())

	// Define API routes
	api := router.Group("/api/v1")
	{
		// Protected routes
		protected := api.Group("/clients")
		protected.Use(handlers.KeycloakAuthMiddleware(daprClient))
		{
			protected.POST("", clientHandler.AddClient)
			protected.GET("", clientHandler.GetClient)
		}

		// Health check
		api.GET("/health", func(c *gin.Context) {
			c.JSON(http.StatusOK, gin.H{"status": "ok"})
		})
	}

	// Start the server
	log.Printf("Starting server on port %s", serverPort)
	if err := router.Run(":" + serverPort); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}

// runMigrations runs database migrations
func runMigrations(db *sql.DB) error {
	driver, err := postgres.WithInstance(db, &postgres.Config{})
	if err != nil {
		return fmt.Errorf("failed to create migration driver: %w", err)
	}

	m, err := migrate.NewWithDatabaseInstance(
		"file://migrations",
		"postgres", driver)
	if err != nil {
		return fmt.Errorf("failed to create migration instance: %w", err)
	}

	if err := m.Up(); err != nil && err != migrate.ErrNoChange {
		return fmt.Errorf("failed to run migrations: %w", err)
	}

	return nil
}

// getEnv gets an environment variable or returns a default value
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}
