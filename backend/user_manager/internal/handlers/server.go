package handlers

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/auth"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/config"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/models"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/repository"
	"github.com/gorilla/mux"
)

// Server represents the HTTP server
type Server struct {
	router   *mux.Router
	server   *http.Server
	userRepo *repository.UserRepository
}

// NewServer creates a new HTTP server
func NewServer(cfg config.ServerConfig, userRepo *repository.UserRepository) *Server {
	router := mux.NewRouter()
	
	server := &Server{
		router: router,
		server: &http.Server{
			Addr:         ":" + cfg.Port,
			Handler:      router,
			ReadTimeout:  cfg.ReadTimeout,
			WriteTimeout: cfg.WriteTimeout,
		},
		userRepo: userRepo,
	}

	// Apply Dapr authentication middleware
	router.Use(auth.DaprAuthMiddleware)

	// Register routes
	server.registerRoutes()

	return server
}

// Start starts the HTTP server
func (s *Server) Start() error {
	log.Printf("Starting server on %s", s.server.Addr)
	return s.server.ListenAndServe()
}

// Shutdown gracefully shuts down the HTTP server
func (s *Server) Shutdown(ctx context.Context) error {
	return s.server.Shutdown(ctx)
}

// registerRoutes registers all HTTP routes
func (s *Server) registerRoutes() {
	// Health check
	s.router.HandleFunc("/health", s.healthHandler).Methods(http.MethodGet)

	// API routes
	api := s.router.PathPrefix("/api/v1").Subrouter()
	
	// Users
	users := api.PathPrefix("/users").Subrouter()
	users.HandleFunc("", s.createUserHandler).Methods(http.MethodPost)
	users.HandleFunc("", s.listUsersHandler).Methods(http.MethodGet)
	users.HandleFunc("/{id}", s.getUserHandler).Methods(http.MethodGet)
	users.HandleFunc("/{id}", s.updateUserHandler).Methods(http.MethodPut)
	users.HandleFunc("/{id}", s.deleteUserHandler).Methods(http.MethodDelete)

	// Dapr subscription endpoints
	s.router.HandleFunc("/dapr/subscribe", s.daprSubscriptionHandler).Methods(http.MethodGet)
}

// healthHandler handles health check requests
func (s *Server) healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]string{"status": "ok", "timestamp": time.Now().Format(time.RFC3339)})
}

// createUserHandler handles user creation requests
func (s *Server) createUserHandler(w http.ResponseWriter, r *http.Request) {
	var req models.CreateUserRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, fmt.Sprintf("Invalid request: %v", err), http.StatusBadRequest)
		return
	}

	user, err := s.userRepo.CreateUser(r.Context(), req)
	if err != nil {
		http.Error(w, fmt.Sprintf("Failed to create user: %v", err), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(user)
}

// listUsersHandler handles requests to list all users
func (s *Server) listUsersHandler(w http.ResponseWriter, r *http.Request) {
	users, err := s.userRepo.ListUsers(r.Context())
	if err != nil {
		http.Error(w, fmt.Sprintf("Failed to list users: %v", err), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(users)
}

// getUserHandler handles requests to get a user by ID
func (s *Server) getUserHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	user, err := s.userRepo.GetUserByID(r.Context(), id)
	if err != nil {
		http.Error(w, fmt.Sprintf("Failed to get user: %v", err), http.StatusInternalServerError)
		return
	}

	if user == nil {
		http.Error(w, "User not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(user)
}

// updateUserHandler handles requests to update a user
func (s *Server) updateUserHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	var user models.User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		http.Error(w, fmt.Sprintf("Invalid request: %v", err), http.StatusBadRequest)
		return
	}

	user.ID = id

	if err := s.userRepo.UpdateUser(r.Context(), &user); err != nil {
		http.Error(w, fmt.Sprintf("Failed to update user: %v", err), http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(user)
}

// deleteUserHandler handles requests to delete a user
func (s *Server) deleteUserHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	if err := s.userRepo.DeleteUser(r.Context(), id); err != nil {
		http.Error(w, fmt.Sprintf("Failed to delete user: %v", err), http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}

// daprSubscriptionHandler handles Dapr subscription requests
func (s *Server) daprSubscriptionHandler(w http.ResponseWriter, r *http.Request) {
	// Define subscriptions for Dapr pub/sub
	subscriptions := []map[string]interface{}{
		{
			"pubsubname": "pubsub",
			"topic":      "user-created",
			"route":      "/api/v1/events/user-created",
		},
	}

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(subscriptions)
}
