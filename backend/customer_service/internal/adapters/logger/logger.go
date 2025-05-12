package logger

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/attribute"
	"go.opentelemetry.io/otel/trace"
)

// Logger is a structured logger that sends logs to Elasticsearch
type Logger struct {
	serviceName    string
	elasticURL     string
	elasticIndex   string
	httpClient     *http.Client
	tracer         trace.Tracer
}

// LogLevel represents the severity of the log message
type LogLevel string

const (
	// LogLevelDebug is for debug messages
	LogLevelDebug LogLevel = "debug"
	// LogLevelInfo is for informational messages
	LogLevelInfo LogLevel = "info"
	// LogLevelWarn is for warning messages
	LogLevelWarn LogLevel = "warn"
	// LogLevelError is for error messages
	LogLevelError LogLevel = "error"
	// LogLevelFatal is for fatal messages
	LogLevelFatal LogLevel = "fatal"
)

// NewLogger creates a new logger
func NewLogger(serviceName, elasticURL, elasticIndex string) *Logger {
	tracer := otel.Tracer(serviceName)
	return &Logger{
		serviceName:  serviceName,
		elasticURL:   elasticURL,
		elasticIndex: elasticIndex,
		httpClient:   &http.Client{Timeout: 5 * time.Second},
		tracer:       tracer,
	}
}

// Debug logs a debug message
func (l *Logger) Debug(ctx context.Context, message string, fields map[string]interface{}) {
	l.log(ctx, LogLevelDebug, message, nil, fields)
}

// Info logs an informational message
func (l *Logger) Info(ctx context.Context, message string, fields map[string]interface{}) {
	l.log(ctx, LogLevelInfo, message, nil, fields)
}

// Warn logs a warning message
func (l *Logger) Warn(ctx context.Context, message string, fields map[string]interface{}) {
	l.log(ctx, LogLevelWarn, message, nil, fields)
}

// Error logs an error message
func (l *Logger) Error(ctx context.Context, message string, err error, fields map[string]interface{}) {
	l.log(ctx, LogLevelError, message, err, fields)
}

// Fatal logs a fatal message and exits the application
func (l *Logger) Fatal(ctx context.Context, message string, err error, fields map[string]interface{}) {
	l.log(ctx, LogLevelFatal, message, err, fields)
	log.Fatalf("%s: %v", message, err)
}

// log sends a log message to Elasticsearch
func (l *Logger) log(ctx context.Context, level LogLevel, message string, err error, fields map[string]interface{}) {
	// Get trace information from context
	span := trace.SpanFromContext(ctx)
	spanContext := span.SpanContext()

	// Create log entry
	logEntry := map[string]interface{}{
		"@timestamp": time.Now().UTC().Format(time.RFC3339),
		"level":      level,
		"message":    message,
		"service":    l.serviceName,
	}

	// Add trace information if available
	if spanContext.IsValid() {
		logEntry["trace_id"] = spanContext.TraceID().String()
		logEntry["span_id"] = spanContext.SpanID().String()
	}

	// Add error information if present
	if err != nil {
		logEntry["error"] = err.Error()
	}

	// Add additional fields
	for k, v := range fields {
		logEntry[k] = v
	}

	// Add log attributes to span
	if spanContext.IsValid() {
		span.SetAttributes(attribute.String("log.level", string(level)))
		span.SetAttributes(attribute.String("log.message", message))
		if err != nil {
			span.SetAttributes(attribute.String("log.error", err.Error()))
		}
	}

	// Convert log entry to JSON
	logJSON, jsonErr := json.Marshal(logEntry)
	if jsonErr != nil {
		log.Printf("Error marshaling log entry: %v", jsonErr)
		return
	}

	// Print to stdout for local development
	fmt.Println(string(logJSON))

	// Send to Elasticsearch if URL is provided
	if l.elasticURL != "" && l.elasticIndex != "" {
		go l.sendToElasticsearch(logJSON)
	}
}

// ensureIndexExists checks if the Elasticsearch index exists and creates it if it doesn't
func (l *Logger) ensureIndexExists() bool {
	// Skip if Elasticsearch URL is not provided
	if l.elasticURL == "" || l.elasticIndex == "" {
		return false
	}

	// Check if index exists
	url := fmt.Sprintf("%s/%s", l.elasticURL, l.elasticIndex)
	req, err := http.NewRequest("HEAD", url, nil)
	if err != nil {
		log.Printf("Error creating Elasticsearch HEAD request: %v", err)
		return false
	}

	resp, err := l.httpClient.Do(req)
	if err != nil {
		// If we can't connect to Elasticsearch, log the error but don't spam the logs
		// with repeated errors
		log.Printf("Error connecting to Elasticsearch: %v", err)
		return false
	}
	defer resp.Body.Close()

	// If index exists, return true
	if resp.StatusCode == 200 {
		return true
	}

	// If index doesn't exist (404), create it
	if resp.StatusCode == 404 {
		// Create index
		createURL := fmt.Sprintf("%s/%s", l.elasticURL, l.elasticIndex)
		indexSettings := `{
			"settings": {
				"number_of_shards": 1,
				"number_of_replicas": 0
			},
			"mappings": {
				"properties": {
					"@timestamp": { "type": "date" },
					"level": { "type": "keyword" },
					"message": { "type": "text" },
					"service": { "type": "keyword" },
					"trace_id": { "type": "keyword" },
					"span_id": { "type": "keyword" },
					"error": { "type": "text" }
				}
			}
		}`

		createReq, err := http.NewRequest("PUT", createURL, bytes.NewBufferString(indexSettings))
		if err != nil {
			log.Printf("Error creating Elasticsearch PUT request: %v", err)
			return false
		}
		createReq.Header.Set("Content-Type", "application/json")

		createResp, err := l.httpClient.Do(createReq)
		if err != nil {
			log.Printf("Error creating Elasticsearch index: %v", err)
			return false
		}
		defer createResp.Body.Close()

		if createResp.StatusCode >= 200 && createResp.StatusCode < 300 {
			log.Printf("Created Elasticsearch index: %s", l.elasticIndex)
			return true
		} else {
			log.Printf("Failed to create Elasticsearch index, status: %d", createResp.StatusCode)
			return false
		}
	}

	// If we get here, something unexpected happened
	log.Printf("Unexpected response from Elasticsearch: %d", resp.StatusCode)
	return false
}

// sendToElasticsearch sends a log entry to Elasticsearch
func (l *Logger) sendToElasticsearch(logJSON []byte) {
	// First, check if the index exists and create it if it doesn't
	if !l.ensureIndexExists() {
		// If we can't ensure the index exists, just log to stdout and return
		return
	}

	// Send the log entry
	url := fmt.Sprintf("%s/%s/_doc", l.elasticURL, l.elasticIndex)
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(logJSON))
	if err != nil {
		log.Printf("Error creating Elasticsearch request: %v", err)
		return
	}

	req.Header.Set("Content-Type", "application/json")

	resp, err := l.httpClient.Do(req)
	if err != nil {
		log.Printf("Error sending log to Elasticsearch: %v", err)
		return
	}
	defer resp.Body.Close()

	if resp.StatusCode >= 400 {
		// Only log the error if it's not a 404, as we've already tried to create the index
		if resp.StatusCode != 404 {
			log.Printf("Elasticsearch returned error status: %d for URL %s", resp.StatusCode, url)
		}
	}
}
