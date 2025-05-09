package handlers

import (
	"log"
	"net/http"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/adapters/temporal"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/domain/entities"
	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/ports/in"
	"github.com/gin-gonic/gin"
	"github.com/google/uuid"
)

// ClientHandler handles HTTP requests for client operations
type ClientHandler struct {
	clientService in.ClientService
	temporalClient *temporal.TemporalClient
}

// NewClientHandler creates a new client handler
func NewClientHandler(clientService in.ClientService, temporalClient *temporal.TemporalClient) *ClientHandler {
	return &ClientHandler{
		clientService: clientService,
		temporalClient: temporalClient,
	}
}

// AddClient handles the request to add a new client
func (h *ClientHandler) AddClient(c *gin.Context) {
	// Get user ID from context (set by auth middleware)
	userID, exists := c.Get("userID")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "User not authenticated"})
		return
	}

	// Parse user ID as UUID
	userUUID, err := uuid.Parse(userID.(string))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID"})
		return
	}

	// Parse request body
	var clientRequest struct {
		FirstName    string `json:"firstName" binding:"required"`
		LastName     string `json:"lastName" binding:"required"`
		ContactEmail string `json:"contactEmail" binding:"required,email"`
		PhoneNumber  string `json:"phoneNumber" binding:"required"`
	}

	if err := c.ShouldBindJSON(&clientRequest); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Create client entity
	client := entities.NewClient(
		userUUID,
		clientRequest.FirstName,
		clientRequest.LastName,
		clientRequest.ContactEmail,
		clientRequest.PhoneNumber,
	)

	// Try to save client using Temporal workflow if available
	if h.temporalClient != nil {
		result, err := h.temporalClient.AddClient(c.Request.Context(), client)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			log.Printf("Temporal workflow failed, falling back to direct service call: %v", err)
		} else {
			// Update client with result from workflow
			client = result
			c.JSON(http.StatusOK, client)
			return
		}
	}

	// Fall back to direct service call if Temporal is not available or failed
	err = h.clientService.AddClient(c.Request.Context(), client)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to save client"})
		return
	}

	c.JSON(http.StatusOK, client)
}

// GetClient handles the request to get a client
func (h *ClientHandler) GetClient(c *gin.Context) {
	// Get user ID from context (set by auth middleware)
	userID, exists := c.Get("userID")
	if !exists {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "User not authenticated"})
		return
	}

	// Parse user ID as UUID
	userUUID, err := uuid.Parse(userID.(string))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid user ID"})
		return
	}

	// Try to get client using Temporal workflow if available
	if h.temporalClient != nil {
		client, err := h.temporalClient.GetClient(c.Request.Context(), userUUID)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			log.Printf("Temporal workflow failed, falling back to direct service call: %v", err)
		} else {
			c.JSON(http.StatusOK, client)
			return
		}
	}

	// Fall back to direct service call if Temporal is not available or failed
	client, err := h.clientService.GetClient(c.Request.Context(), userUUID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to retrieve client"})
		return
	}

	c.JSON(http.StatusOK, client)
}
