package auth

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"strings"

	"github.com/b-fontaine/saaster_kit/backend/user_manager/internal/config"
)

// KeycloakAuth handles Keycloak authentication
type KeycloakAuth struct {
	keycloakURL string
}

// NewKeycloakAuth creates a new KeycloakAuth
func NewKeycloakAuth(cfg config.DaprConfig) *KeycloakAuth {
	return &KeycloakAuth{
		keycloakURL: cfg.KeycloakURL,
	}
}

// TokenValidationMiddleware validates JWT tokens from Keycloak
func (k *KeycloakAuth) TokenValidationMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// Extract token from Authorization header
		authHeader := r.Header.Get("Authorization")
		if authHeader == "" {
			http.Error(w, "Authorization header is required", http.StatusUnauthorized)
			return
		}

		parts := strings.Split(authHeader, " ")
		if len(parts) != 2 || parts[0] != "Bearer" {
			http.Error(w, "Authorization header format must be Bearer {token}", http.StatusUnauthorized)
			return
		}

		token := parts[1]

		// Validate token using Dapr middleware
		// In a real implementation, we would use Dapr's middleware component
		// Here we're just checking if the token is present
		if token == "" {
			http.Error(w, "Invalid token", http.StatusUnauthorized)
			return
		}

		// Call the next handler
		next.ServeHTTP(w, r)
	})
}

// UserInfo represents user information from Keycloak
type UserInfo struct {
	Sub               string   `json:"sub"`
	Email             string   `json:"email"`
	PreferredUsername string   `json:"preferred_username"`
	Name              string   `json:"name"`
	GivenName         string   `json:"given_name"`
	FamilyName        string   `json:"family_name"`
	RealmAccess       struct{} `json:"realm_access"`
	ResourceAccess    struct{} `json:"resource_access"`
}

// GetUserInfo gets user information from Keycloak
func (k *KeycloakAuth) GetUserInfo(ctx context.Context, token string) (*UserInfo, error) {
	// In a real implementation, we would use Dapr to call Keycloak
	// Here we're just returning a mock user info
	if token == "" {
		return nil, errors.New("token is required")
	}

	// Mock user info
	userInfo := &UserInfo{
		Sub:               "user-id",
		Email:             "user@example.com",
		PreferredUsername: "username",
		Name:              "User Name",
		GivenName:         "User",
		FamilyName:        "Name",
	}

	return userInfo, nil
}

// DaprAuthMiddleware is a middleware that uses Dapr for authentication
func DaprAuthMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		// In a real implementation, we would use Dapr's middleware component
		// Here we're just checking if the Dapr-API-Token header is present
		daprToken := r.Header.Get("Dapr-API-Token")
		if daprToken == "" {
			// If no Dapr token, check for Authorization header
			authHeader := r.Header.Get("Authorization")
			if authHeader == "" {
				http.Error(w, "Authentication required", http.StatusUnauthorized)
				return
			}
		}

		// Call the next handler
		next.ServeHTTP(w, r)
	})
}

// DaprClient is a client for Dapr
type DaprClient struct {
	appID    string
	httpPort string
}

// NewDaprClient creates a new DaprClient
func NewDaprClient(cfg config.DaprConfig) *DaprClient {
	return &DaprClient{
		appID:    cfg.AppID,
		httpPort: cfg.HttpPort,
	}
}

// CallKeycloakService calls Keycloak service through Dapr
func (c *DaprClient) CallKeycloakService(ctx context.Context, path string, method string, body interface{}) ([]byte, error) {
	// In a real implementation, we would use Dapr's HTTP client
	// Here we're just returning a mock response
	mockResponse := map[string]interface{}{
		"status": "success",
		"data":   "mock data",
	}

	return json.Marshal(mockResponse)
}

// ValidateToken validates a token with Keycloak through Dapr
func (c *DaprClient) ValidateToken(ctx context.Context, token string) (bool, error) {
	// In a real implementation, we would use Dapr to call Keycloak
	// Here we're just returning a mock response
	if token == "" {
		return false, fmt.Errorf("token is required")
	}

	return true, nil
}
