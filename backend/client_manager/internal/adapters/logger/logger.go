package logger

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"time"

	dapr "github.com/dapr/go-sdk/client"
)

// Logger is a structured logger that sends logs to Dapr
type Logger struct {
	daprClient dapr.Client
	serviceName string
	defaultFields map[string]interface{}
}

// LogLevel represents the severity of the log message
type LogLevel string

const (
	// Debug level for detailed information
	Debug LogLevel = "debug"
	// Info level for general operational information
	Info LogLevel = "info"
	// Warn level for warning conditions
	Warn LogLevel = "warn"
	// Error level for error conditions
	Error LogLevel = "error"
	// Fatal level for fatal conditions
	Fatal LogLevel = "fatal"
)

// LogEntry represents a structured log entry
type LogEntry struct {
	Level     string                 `json:"level"`
	Message   string                 `json:"msg"`
	Timestamp string                 `json:"time"`
	Service   string                 `json:"service"`
	TraceID   string                 `json:"trace_id,omitempty"`
	SpanID    string                 `json:"span_id,omitempty"`
	Fields    map[string]interface{} `json:"fields,omitempty"`
}

// NewLogger creates a new structured logger
func NewLogger(daprClient dapr.Client, serviceName string) *Logger {
	return &Logger{
		daprClient:    daprClient,
		serviceName:   serviceName,
		defaultFields: make(map[string]interface{}),
	}
}

// WithFields adds default fields to the logger
func (l *Logger) WithFields(fields map[string]interface{}) *Logger {
	newLogger := &Logger{
		daprClient:    l.daprClient,
		serviceName:   l.serviceName,
		defaultFields: make(map[string]interface{}),
	}

	// Copy existing default fields
	for k, v := range l.defaultFields {
		newLogger.defaultFields[k] = v
	}

	// Add new fields
	for k, v := range fields {
		newLogger.defaultFields[k] = v
	}

	return newLogger
}

// log sends a log entry to Dapr
func (l *Logger) log(ctx context.Context, level LogLevel, msg string, fields map[string]interface{}) {
	// Create log entry
	entry := LogEntry{
		Level:     string(level),
		Message:   msg,
		Timestamp: time.Now().UTC().Format(time.RFC3339),
		Service:   l.serviceName,
		Fields:    make(map[string]interface{}),
	}

	// Add trace context if available
	if ctx != nil {
		if traceID, ok := ctx.Value("trace_id").(string); ok {
			entry.TraceID = traceID
		}
		if spanID, ok := ctx.Value("span_id").(string); ok {
			entry.SpanID = spanID
		}
	}

	// Add default fields
	for k, v := range l.defaultFields {
		entry.Fields[k] = v
	}

	// Add additional fields
	for k, v := range fields {
		entry.Fields[k] = v
	}

	// Convert to JSON
	jsonData, err := json.Marshal(entry)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error marshaling log entry: %v\n", err)
		return
	}

	// Send to Dapr
	if l.daprClient != nil {
		// Create metadata for the HTTP binding
		metadata := map[string]string{
			"Content-Type": "application/json",
		}

		// Send to Elasticsearch via HTTP binding
		_, err = l.daprClient.InvokeBinding(ctx, &dapr.InvokeBindingRequest{
			Name:      "elasticsearch-logs",
			Operation: "post", // HTTP binding uses lowercase HTTP methods
			Data:      jsonData,
			Metadata:  metadata,
		})
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error sending log to Dapr: %v\n", err)
		}
	}

	// Also print to stdout for local development
	fmt.Println(string(jsonData))
}

// Debug logs a debug message
func (l *Logger) Debug(ctx context.Context, msg string, fields map[string]interface{}) {
	l.log(ctx, Debug, msg, fields)
}

// Info logs an info message
func (l *Logger) Info(ctx context.Context, msg string, fields map[string]interface{}) {
	l.log(ctx, Info, msg, fields)
}

// Warn logs a warning message
func (l *Logger) Warn(ctx context.Context, msg string, fields map[string]interface{}) {
	l.log(ctx, Warn, msg, fields)
}

// Error logs an error message
func (l *Logger) Error(ctx context.Context, msg string, err error, fields map[string]interface{}) {
	if fields == nil {
		fields = make(map[string]interface{})
	}
	if err != nil {
		fields["error"] = err.Error()
	}
	l.log(ctx, Error, msg, fields)
}

// Fatal logs a fatal message and exits
func (l *Logger) Fatal(ctx context.Context, msg string, err error, fields map[string]interface{}) {
	if fields == nil {
		fields = make(map[string]interface{})
	}
	if err != nil {
		fields["error"] = err.Error()
	}
	l.log(ctx, Fatal, msg, fields)
	os.Exit(1)
}
