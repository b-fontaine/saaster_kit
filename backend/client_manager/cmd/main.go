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
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/adapters/logger"
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

	// Initialize context
	ctx := context.Background()

	// Initialize Dapr client
	daprClient, err := dapr.NewClient()
	if err != nil {
		log.Fatalf("Failed to create Dapr client: %v", err)
	}
	defer daprClient.Close()

	// Initialize structured logger
	appLogger := logger.NewLogger(daprClient, "client-manager")
	appLogger.Info(ctx, "Starting client_manager service", map[string]interface{}{
		"version": "1.0.0",
	})

	// Connect to the database
	dbURL := fmt.Sprintf("postgres://%s:%s@%s:%s/%s?sslmode=disable",
		dbUser, dbPassword, dbHost, dbPort, dbName)

	db, err := sql.Open("postgres", dbURL)
	if err != nil {
		appLogger.Fatal(ctx, "Failed to connect to database", err, nil)
	}
	defer db.Close()

	// Set connection pool parameters
	db.SetMaxOpenConns(25)
	db.SetMaxIdleConns(5)
	db.SetConnMaxLifetime(5 * time.Minute)

	// Check database connection
	dbCtx, cancel := context.WithTimeout(ctx, 5*time.Second)
	defer cancel()

	if err := db.PingContext(dbCtx); err != nil {
		appLogger.Fatal(ctx, "Failed to ping database", err, nil)
	}
	appLogger.Info(ctx, "Connected to database successfully", nil)

	// Run database migrations
	if err := runMigrations(db); err != nil {
		appLogger.Fatal(ctx, "Failed to run migrations", err, nil)
	}
	appLogger.Info(ctx, "Migrations completed successfully", nil)

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
		appLogger.Warn(ctx, "Failed to create Temporal client, retrying", map[string]interface{}{
			"attempt": i + 1,
			"error":   temporalErr.Error(),
			"retry_in": "5 seconds",
		})
		time.Sleep(5 * time.Second)
	}

	if temporalErr != nil {
		appLogger.Error(ctx, "Could not connect to Temporal after multiple attempts", temporalErr, map[string]interface{}{
			"impact": "The application will start without Temporal integration",
		})
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
			appLogger.Error(ctx, "Failed to start Temporal worker", workerErr, map[string]interface{}{
				"impact": "The application will start without Temporal worker",
			})
		} else {
			appLogger.Info(ctx, "Temporal worker started successfully", map[string]interface{}{
				"namespace": temporalNamespace,
				"taskQueue": temporalTaskQueue,
			})
		}
	}

	// Initialize handlers
	clientHandler := handlers.NewClientHandler(clientService, temporalClient)

	// Set up Gin router with the logger middleware
	router := gin.New()

	// Add middleware
	router.Use(gin.Recovery())

	// Add custom logging middleware
	router.Use(func(c *gin.Context) {
		start := time.Now()
		path := c.Request.URL.Path
		method := c.Request.Method

		c.Next()

		latency := time.Since(start)
		status := c.Writer.Status()

		logFields := map[string]interface{}{
			"method":   method,
			"path":     path,
			"status":   status,
			"latency":  latency.String(),
			"client_ip": c.ClientIP(),
		}

		if status >= 400 {
			appLogger.Error(ctx, "API request failed", nil, logFields)
		} else {
			appLogger.Info(ctx, "API request completed", logFields)
		}
	})

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
	appLogger.Info(ctx, "Starting server", map[string]interface{}{
		"port": serverPort,
	})
	if err := router.Run(":" + serverPort); err != nil {
		appLogger.Fatal(ctx, "Failed to start server", err, nil)
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
