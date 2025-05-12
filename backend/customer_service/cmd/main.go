package main

import (
	"context"
	"database/sql"
	"fmt"
	"log"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/adapters/grpc"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/adapters/logger"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/adapters/repositories"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/adapters/temporal"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/application/services"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/workflows"
	"github.com/golang-migrate/migrate/v4"
	"github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
	_ "github.com/lib/pq"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
	"go.opentelemetry.io/otel/sdk/resource"
	sdktrace "go.opentelemetry.io/otel/sdk/trace"
	semconv "go.opentelemetry.io/otel/semconv/v1.17.0"
	"go.temporal.io/sdk/client"
	"go.temporal.io/sdk/worker"
)

func main() {
	// Get environment variables
	dbHost := getEnv("DB_HOST", "localhost")
	dbPort := getEnv("DB_PORT", "5432")
	dbUser := getEnv("DB_USER", "postgres")
	dbPassword := getEnv("DB_PASSWORD", "password")
	dbName := getEnv("DB_NAME", "customer_service_db")
	grpcPort := getEnv("GRPC_PORT", "50051")
	temporalAddress := getEnv("TEMPORAL_ADDRESS", "localhost:7233")
	temporalNamespace := getEnv("TEMPORAL_NAMESPACE", "customer-namespace")
	temporalTaskQueue := getEnv("TEMPORAL_TASK_QUEUE", "customer-service-task-queue")
	otlpEndpoint := getEnv("OTLP_ENDPOINT", "localhost:4317")
	elasticURL := getEnv("ELASTIC_URL", "http://localhost:9200")
	elasticIndex := getEnv("ELASTIC_INDEX", "customer-service-logs")
	keycloakURL := getEnv("KEYCLOAK_URL", "http://localhost:8080")

	// Create context that listens for the interrupt signal from the OS
	ctx, stop := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer stop()

	// Initialize OpenTelemetry
	tp, err := initTracer(ctx, "customer-service", otlpEndpoint)
	if err != nil {
		log.Fatalf("Failed to initialize tracer: %v", err)
	}
	defer func() {
		if err := tp.Shutdown(context.Background()); err != nil {
			log.Printf("Error shutting down tracer provider: %v", err)
		}
	}()

	// Initialize structured logger
	appLogger := logger.NewLogger("customer-service", elasticURL, elasticIndex)
	appLogger.Info(ctx, "Starting customer_service service", map[string]interface{}{
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
	customerRepo := repositories.NewCustomerRepository(db)

	// Initialize services
	customerService := services.NewCustomerService(customerRepo)

	// Initialize Temporal client with retries
	var temporalClient *temporal.TemporalClient
	var temporalErr error
	for i := 0; i < 5; i++ {
		temporalClient, temporalErr = temporal.NewTemporalClient(temporalAddress, temporalNamespace, temporalTaskQueue)
		if temporalErr == nil {
			break
		}
		appLogger.Warn(ctx, "Failed to create Temporal client, retrying", map[string]interface{}{
			"attempt":  i + 1,
			"error":    temporalErr.Error(),
			"retry_in": "5 seconds",
		})
		time.Sleep(5 * time.Second)
	}

	if temporalErr != nil {
		appLogger.Error(ctx, "Failed to create Temporal client after retries", temporalErr, nil)
	} else {
		appLogger.Info(ctx, "Connected to Temporal successfully", map[string]interface{}{
			"namespace": temporalNamespace,
			"taskQueue": temporalTaskQueue,
		})
		defer temporalClient.Close()

		// Start Temporal worker
		temporalWorker, err := startTemporalWorker(temporalClient.Client, temporalTaskQueue, *customerService)
		if err != nil {
			appLogger.Fatal(ctx, "Failed to start Temporal worker", err, nil)
		}
		defer temporalWorker.Stop()
	}

	// Initialize gRPC server
	grpcServer := grpc.NewServer(customerService, temporalClient, appLogger, keycloakURL)

	// Start gRPC server
	go func() {
		if err := grpcServer.Start(ctx, grpcPort); err != nil {
			appLogger.Fatal(ctx, "Failed to start gRPC server", err, nil)
		}
	}()

	// Wait for interrupt signal
	<-ctx.Done()
	appLogger.Info(ctx, "Shutting down gracefully", nil)
}

// startTemporalWorker starts a Temporal worker
func startTemporalWorker(c client.Client, taskQueue string, customerService services.CustomerService) (worker.Worker, error) {
	w := worker.New(c, taskQueue, worker.Options{})

	// Register workflows
	w.RegisterWorkflow(workflows.AddCustomerWorkflow)
	w.RegisterWorkflow(workflows.GetCustomerWorkflow)
	w.RegisterWorkflow(workflows.UpdateCustomerWorkflow)
	w.RegisterWorkflow(workflows.ListCustomersWorkflow)

	// Register activities
	activities := workflows.NewActivities(&customerService)
	w.RegisterActivity(activities.AddCustomerActivity)
	w.RegisterActivity(activities.GetCustomerActivity)
	w.RegisterActivity(activities.UpdateCustomerActivity)
	w.RegisterActivity(activities.ListCustomersActivity)

	// Start worker
	err := w.Start()
	if err != nil {
		return nil, fmt.Errorf("failed to start Temporal worker: %w", err)
	}

	return w, nil
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

// initTracer initializes an OTLP exporter and configures the corresponding trace provider
func initTracer(ctx context.Context, serviceName, otlpEndpoint string) (*sdktrace.TracerProvider, error) {
	// Create OTLP exporter
	exporter, err := otlptrace.New(
		ctx,
		otlptracegrpc.NewClient(
			otlptracegrpc.WithInsecure(),
			otlptracegrpc.WithEndpoint(otlpEndpoint),
		),
	)
	if err != nil {
		return nil, fmt.Errorf("failed to create OTLP exporter: %w", err)
	}

	// Create resource
	res, err := resource.New(ctx,
		resource.WithAttributes(
			semconv.ServiceName(serviceName),
		),
	)
	if err != nil {
		return nil, fmt.Errorf("failed to create resource: %w", err)
	}

	// Create trace provider
	tp := sdktrace.NewTracerProvider(
		sdktrace.WithSampler(sdktrace.AlwaysSample()),
		sdktrace.WithBatcher(exporter),
		sdktrace.WithResource(res),
	)

	// Set global trace provider
	otel.SetTracerProvider(tp)

	return tp, nil
}

// getEnv gets an environment variable or returns a default value
func getEnv(key, defaultValue string) string {
	value := os.Getenv(key)
	if value == "" {
		return defaultValue
	}
	return value
}
