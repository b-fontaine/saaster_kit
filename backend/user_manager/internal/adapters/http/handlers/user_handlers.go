package handlers

import (
	"encoding/json"
	"net/http"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/application/commands"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/application/queries"
	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/domain"
	"github.com/gorilla/mux"
)

// UserResponse represents the response for a user
type UserResponse struct {
	ID        string `json:"id"`
	Email     string `json:"email"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	Role      string `json:"role"`
	Active    bool   `json:"active"`
	CreatedAt string `json:"created_at"`
	UpdatedAt string `json:"updated_at"`
}

// CreateUserRequest represents the request to create a user
type CreateUserRequest struct {
	Email     string `json:"email"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	Role      string `json:"role"`
}

// UpdateUserRequest represents the request to update a user
type UpdateUserRequest struct {
	Email     string `json:"email"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	Role      string `json:"role"`
	Active    bool   `json:"active"`
}

// UserHandler handles HTTP requests for users
type UserHandler struct {
	createUserHandler *commands.CreateUserHandler
	updateUserHandler *commands.UpdateUserHandler
	deleteUserHandler *commands.DeleteUserHandler
	getUserByIDHandler *queries.GetUserByIDHandler
	listUsersHandler *queries.ListUsersHandler
}

// NewUserHandler creates a new UserHandler
func NewUserHandler(
	createUserHandler *commands.CreateUserHandler,
	updateUserHandler *commands.UpdateUserHandler,
	deleteUserHandler *commands.DeleteUserHandler,
	getUserByIDHandler *queries.GetUserByIDHandler,
	listUsersHandler *queries.ListUsersHandler,
) *UserHandler {
	return &UserHandler{
		createUserHandler: createUserHandler,
		updateUserHandler: updateUserHandler,
		deleteUserHandler: deleteUserHandler,
		getUserByIDHandler: getUserByIDHandler,
		listUsersHandler: listUsersHandler,
	}
}

// RegisterRoutes registers the routes for the UserHandler
func (h *UserHandler) RegisterRoutes(router *mux.Router) {
	router.HandleFunc("/users", h.CreateUser).Methods(http.MethodPost)
	router.HandleFunc("/users", h.ListUsers).Methods(http.MethodGet)
	router.HandleFunc("/users/{id}", h.GetUser).Methods(http.MethodGet)
	router.HandleFunc("/users/{id}", h.UpdateUser).Methods(http.MethodPut)
	router.HandleFunc("/users/{id}", h.DeleteUser).Methods(http.MethodDelete)
}

// CreateUser handles the request to create a user
func (h *UserHandler) CreateUser(w http.ResponseWriter, r *http.Request) {
	var req CreateUserRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	cmd := commands.CreateUserCommand{
		Email:     req.Email,
		FirstName: req.FirstName,
		LastName:  req.LastName,
		Role:      req.Role,
	}

	user, err := h.createUserHandler.Handle(r.Context(), cmd)
	if err != nil {
		handleError(w, err)
		return
	}

	respondWithJSON(w, http.StatusCreated, toUserResponse(user))
}

// GetUser handles the request to get a user
func (h *UserHandler) GetUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	query := queries.GetUserByIDQuery{
		ID: id,
	}

	user, err := h.getUserByIDHandler.Handle(r.Context(), query)
	if err != nil {
		handleError(w, err)
		return
	}

	if user == nil {
		http.Error(w, "User not found", http.StatusNotFound)
		return
	}

	respondWithJSON(w, http.StatusOK, toUserResponse(user))
}

// UpdateUser handles the request to update a user
func (h *UserHandler) UpdateUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	var req UpdateUserRequest
	if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	cmd := commands.UpdateUserCommand{
		ID:        id,
		Email:     req.Email,
		FirstName: req.FirstName,
		LastName:  req.LastName,
		Role:      req.Role,
	}

	user, err := h.updateUserHandler.Handle(r.Context(), cmd)
	if err != nil {
		handleError(w, err)
		return
	}

	respondWithJSON(w, http.StatusOK, toUserResponse(user))
}

// DeleteUser handles the request to delete a user
func (h *UserHandler) DeleteUser(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id := vars["id"]

	cmd := commands.DeleteUserCommand{
		ID: id,
	}

	err := h.deleteUserHandler.Handle(r.Context(), cmd)
	if err != nil {
		handleError(w, err)
		return
	}

	w.WriteHeader(http.StatusNoContent)
}

// ListUsers handles the request to list users
func (h *UserHandler) ListUsers(w http.ResponseWriter, r *http.Request) {
	query := queries.ListUsersQuery{}

	users, err := h.listUsersHandler.Handle(r.Context(), query)
	if err != nil {
		handleError(w, err)
		return
	}

	var response []UserResponse
	for _, user := range users {
		response = append(response, toUserResponse(user))
	}

	respondWithJSON(w, http.StatusOK, response)
}

// Helper functions

func toUserResponse(user *domain.User) UserResponse {
	return UserResponse{
		ID:        user.ID,
		Email:     user.Email,
		FirstName: user.FirstName,
		LastName:  user.LastName,
		Role:      user.Role,
		Active:    user.Active,
		CreatedAt: user.CreatedAt.Format("2006-01-02T15:04:05Z07:00"),
		UpdatedAt: user.UpdatedAt.Format("2006-01-02T15:04:05Z07:00"),
	}
}

func respondWithJSON(w http.ResponseWriter, status int, data interface{}) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)
	json.NewEncoder(w).Encode(data)
}

func handleError(w http.ResponseWriter, err error) {
	switch err {
	case domain.ErrUserNotFound:
		http.Error(w, err.Error(), http.StatusNotFound)
	case domain.ErrUserAlreadyExists:
		http.Error(w, err.Error(), http.StatusConflict)
	case domain.ErrInvalidUserData:
		http.Error(w, err.Error(), http.StatusBadRequest)
	default:
		// Check if it's a validation error
		if _, ok := err.(domain.ValidationError); ok {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}
		http.Error(w, "Internal server error", http.StatusInternalServerError)
	}
}
