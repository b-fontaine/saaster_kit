package handlers

import (
	"context"
	"net/http"
	"strings"

	dapr "github.com/dapr/go-sdk/client"
	"github.com/gin-gonic/gin"
)

// KeycloakAuthMiddleware validates JWT tokens using Dapr and Keycloak
func KeycloakAuthMiddleware(daprClient dapr.Client) gin.HandlerFunc {
	return func(c *gin.Context) {
		// Get the Authorization header
		authHeader := c.GetHeader("Authorization")
		if authHeader == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization header is required"})
			c.Abort()
			return
		}

		// Check if the header has the Bearer prefix
		if !strings.HasPrefix(authHeader, "Bearer ") {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Authorization header must be Bearer token"})
			c.Abort()
			return
		}

		// Extract the token
		token := strings.TrimPrefix(authHeader, "Bearer ")

		// Call Dapr sidecar to validate the token with Keycloak
		// The component name should match the Dapr component for Keycloak
		content := &dapr.DataContent{
			ContentType: "application/json",
			Data:        []byte(token),
		}

		resp, err := daprClient.InvokeBinding(context.Background(), &dapr.InvokeBindingRequest{
			Name:      "keycloak-auth",
			Operation: "validate",
			Data:      content.Data,
		})

		if err != nil {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Failed to validate token"})
			c.Abort()
			return
		}

		// Parse the response to get user ID
		// This is a simplified example - in a real implementation, you would parse the JWT
		// or the response from Keycloak to get the user ID
		userID := string(resp.Data)
		if userID == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Invalid token"})
			c.Abort()
			return
		}

		// Set the user ID in the context
		c.Set("userID", userID)
		c.Next()
	}
}
