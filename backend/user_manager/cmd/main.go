package main

import (
	"context"
	"database/sql"
	"log"
	"os"
	"os/signal"
	"syscall"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/config"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/handlers"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/repository"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/temporal"
)

func main() {
	// Load configuration
	cfg, err := config.Load()
	if err != nil {
		log.Fatalf("Failed to load configuration: %v", err)
	}

	// Set up context with cancellation for graceful shutdown
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()

	// Initialize database connection
	db, err := repository.NewPostgresDB(cfg.Database)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer func(db *sql.DB) {
		_ = db.Close()
	}(db)

	// Run database migrations
	if err := repository.RunMigrations(db); err != nil {
		log.Fatalf("Failed to run database migrations: %v", err)
	}

	// Initialize repositories
	userRepo := repository.NewUserRepository(db)

	// Initialize Temporal worker
	temporalWorker, err := temporal.NewWorker(cfg.Temporal, userRepo)
	if err != nil {
		log.Fatalf("Failed to create Temporal worker: %v", err)
	}

	// Start Temporal worker
	go func() {
		if err := temporalWorker.Start(); err != nil {
			log.Fatalf("Failed to start Temporal worker: %v", err)
		}
	}()
	defer temporalWorker.Stop()

	// Initialize HTTP server with Dapr middleware for Keycloak token validation
	server := handlers.NewServer(cfg.Server, userRepo)

	// Start HTTP server
	go func() {
		if err := server.Start(); err != nil {
			log.Fatalf("Failed to start server: %v", err)
		}
	}()

	// Wait for termination signal
	sigCh := make(chan os.Signal, 1)
	signal.Notify(sigCh, syscall.SIGINT, syscall.SIGTERM)
	<-sigCh

	log.Println("Shutting down gracefully...")

	// Shutdown HTTP server
	if err := server.Shutdown(ctx); err != nil {
		log.Printf("Error during server shutdown: %v", err)
	}

	log.Println("Service stopped")
}
