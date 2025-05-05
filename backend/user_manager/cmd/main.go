package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	temporaladapter "github.com/b-fontaine/saaster_kit/backend/user_manager/internal/adapters/temporal"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/infrastructure/config"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/infrastructure/database"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/infrastructure/di"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/infrastructure/server"
	"go.temporal.io/sdk/client"
	"go.temporal.io/sdk/worker"
)

func main() {
	// Load configuration
	cfg, err := config.Load()
	if err != nil {
		log.Fatalf("Failed to load configuration: %v", err)
	}

	// Set up context with cancellation for graceful shutdown
	_, cancel := context.WithCancel(context.Background())
	defer cancel()

	// Initialize database connection
	db, err := database.NewPostgresDB(cfg.Database)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer db.Close()

	// Run database migrations
	if err := database.RunMigrations(db); err != nil {
		log.Fatalf("Failed to run database migrations: %v", err)
	}

	// Initialize dependency injection container
	container := di.NewContainer(db, false) // Use PostgreSQL in production

	// Initialize Temporal client
	temporalClient, err := client.NewClient(client.Options{
		HostPort:  cfg.Temporal.Address,
		Namespace: cfg.Temporal.Namespace,
	})
	if err != nil {
		log.Fatalf("Failed to create Temporal client: %v", err)
	}
	defer temporalClient.Close()

	// Initialize Temporal worker
	temporalWorker := worker.New(temporalClient, cfg.Temporal.TaskQueue, worker.Options{
		Identity: cfg.Temporal.WorkerName,
	})

	// Initialize Temporal workflows
	createUserWorkflow := temporaladapter.NewCreateUserWorkflow(container.CreateUserHandler)
	workflowRegistry := temporaladapter.NewWorker(createUserWorkflow)

	// Register workflows and activities
	workflowRegistry.RegisterWorkflows(temporalWorker)
	workflowRegistry.RegisterActivities(temporalWorker)

	// Start Temporal worker
	go func() {
		if err := temporalWorker.Run(worker.InterruptCh()); err != nil {
			log.Fatalf("Failed to start Temporal worker: %v", err)
		}
	}()

	// Initialize HTTP server
	httpServer := server.NewServer(cfg.Server, container.UserHandler)

	// Start HTTP server
	go func() {
		if err := httpServer.Start(); err != nil && err != http.ErrServerClosed {
			log.Fatalf("Failed to start server: %v", err)
		}
	}()

	// Wait for interrupt signal to gracefully shut down the server
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)
	<-quit
	log.Println("Shutting down server...")

	// Create a deadline to wait for
	shutdownCtx, shutdownCancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer shutdownCancel()

	// Shut down the server
	if err := httpServer.Stop(shutdownCtx); err != nil {
		log.Fatalf("Server forced to shutdown: %v", err)
	}

	log.Println("Server exiting")
}
