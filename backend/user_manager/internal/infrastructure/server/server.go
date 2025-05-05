package server

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/adapters/http/handlers"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/infrastructure/config"
	"github.com/gorilla/mux"
)

// Server represents the HTTP server
type Server struct {
	router   *mux.Router
	server   *http.Server
	handlers *handlers.UserHandler
}

// NewServer creates a new HTTP server
func NewServer(cfg config.ServerConfig, handlers *handlers.UserHandler) *Server {
	router := mux.NewRouter()
	
	server := &Server{
		router: router,
		server: &http.Server{
			Addr:         ":" + cfg.Port,
			Handler:      router,
			ReadTimeout:  cfg.ReadTimeout,
			WriteTimeout: cfg.WriteTimeout,
		},
		handlers: handlers,
	}

	// Register routes
	server.registerRoutes()

	return server
}

// Start starts the HTTP server
func (s *Server) Start() error {
	log.Printf("Starting server on %s", s.server.Addr)
	return s.server.ListenAndServe()
}

// Stop stops the HTTP server
func (s *Server) Stop(ctx context.Context) error {
	log.Println("Stopping server")
	return s.server.Shutdown(ctx)
}

// registerRoutes registers all HTTP routes
func (s *Server) registerRoutes() {
	// Health check
	s.router.HandleFunc("/health", s.healthHandler).Methods(http.MethodGet)

	// API routes
	api := s.router.PathPrefix("/api/v1").Subrouter()
	
	// Register user handlers
	s.handlers.RegisterRoutes(api)

	// Dapr subscription endpoints
	s.router.HandleFunc("/dapr/subscribe", s.daprSubscriptionHandler).Methods(http.MethodGet)
}

// healthHandler handles health check requests
func (s *Server) healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, `{"status":"UP","time":"%s"}`, time.Now().Format(time.RFC3339))
}

// daprSubscriptionHandler handles Dapr subscription requests
func (s *Server) daprSubscriptionHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, `[{"pubsubname":"pubsub","topic":"user-created","route":"/api/v1/events/user-created"}]`)
}
