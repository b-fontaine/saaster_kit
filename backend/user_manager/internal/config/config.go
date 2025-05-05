package config

import (
	"os"
	"strconv"
	"time"
)

// Config holds all configuration for the service
type Config struct {
	Server   ServerConfig
	Database DatabaseConfig
	Temporal TemporalConfig
	Dapr     DaprConfig
}

// ServerConfig holds HTTP server configuration
type ServerConfig struct {
	Port         string
	ReadTimeout  time.Duration
	WriteTimeout time.Duration
}

// DatabaseConfig holds database configuration
type DatabaseConfig struct {
	Host     string
	Port     string
	User     string
	Password string
	DBName   string
	SSLMode  string
}

// TemporalConfig holds Temporal configuration
type TemporalConfig struct {
	Address    string
	Namespace  string
	TaskQueue  string
	WorkerName string
}

// DaprConfig holds Dapr configuration
type DaprConfig struct {
	AppID       string
	AppPort     string
	GrpcPort    string
	HttpPort    string
	KeycloakURL string
}

// Load loads configuration from environment variables
func Load() (*Config, error) {
	return &Config{
		Server: ServerConfig{
			Port:         getEnv("SERVER_PORT", "8080"),
			ReadTimeout:  getDurationEnv("SERVER_READ_TIMEOUT", 5*time.Second),
			WriteTimeout: getDurationEnv("SERVER_WRITE_TIMEOUT", 10*time.Second),
		},
		Database: DatabaseConfig{
			Host:     getEnv("DB_HOST", "user_db"),
			Port:     getEnv("DB_PORT", "5432"),
			User:     getEnv("DB_USER", "user_manager"),
			Password: getEnv("DB_PASSWORD", "password"),
			DBName:   getEnv("DB_NAME", "user_db"),
			SSLMode:  getEnv("DB_SSLMODE", "disable"),
		},
		Temporal: TemporalConfig{
			Address:    getEnv("TEMPORAL_ADDRESS", "temporal:7233"),
			Namespace:  getEnv("TEMPORAL_NAMESPACE", "default"),
			TaskQueue:  getEnv("TEMPORAL_TASK_QUEUE", "user-manager-task-queue"),
			WorkerName: getEnv("TEMPORAL_WORKER_NAME", "user-manager-worker"),
		},
		Dapr: DaprConfig{
			AppID:       getEnv("DAPR_APP_ID", "user-manager"),
			AppPort:     getEnv("DAPR_APP_PORT", "8080"),
			GrpcPort:    getEnv("DAPR_GRPC_PORT", "50001"),
			HttpPort:    getEnv("DAPR_HTTP_PORT", "3500"),
			KeycloakURL: getEnv("KEYCLOAK_URL", "http://keycloak:8080"),
		},
	}, nil
}

// Helper functions to get environment variables with defaults
func getEnv(key, defaultValue string) string {
	if value, exists := os.LookupEnv(key); exists {
		return value
	}
	return defaultValue
}

func getIntEnv(key string, defaultValue int) int {
	if value, exists := os.LookupEnv(key); exists {
		if intValue, err := strconv.Atoi(value); err == nil {
			return intValue
		}
	}
	return defaultValue
}

func getDurationEnv(key string, defaultValue time.Duration) time.Duration {
	if value, exists := os.LookupEnv(key); exists {
		if duration, err := time.ParseDuration(value); err == nil {
			return duration
		}
	}
	return defaultValue
}
