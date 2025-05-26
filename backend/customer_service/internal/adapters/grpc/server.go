package grpc

import (
	"context"
	"fmt"
	"net"

	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/adapters/logger"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/adapters/temporal"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/domain/entities"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/internal/ports/in"
	"github.com/b-fontaine/saaster_kit/backend/customer_service/proto"
	"github.com/google/uuid"
	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/metadata"
	"google.golang.org/grpc/reflection"
	"google.golang.org/grpc/status"
)

// Server is the gRPC server for the customer service
type Server struct {
	customer.UnimplementedCustomerServiceServer
	customerService in.CustomerService
	temporalClient  *temporal.TemporalClient
	logger          *logger.Logger
	keycloakURL     string
}

// NewServer creates a new gRPC server
func NewServer(customerService in.CustomerService, temporalClient *temporal.TemporalClient, logger *logger.Logger, keycloakURL string) *Server {
	return &Server{
		customerService: customerService,
		temporalClient:  temporalClient,
		logger:          logger,
		keycloakURL:     keycloakURL,
	}
}

// Start starts the gRPC server
func (s *Server) Start(ctx context.Context, port string) error {
	lis, err := net.Listen("tcp", fmt.Sprintf(":%s", port))
	if err != nil {
		return fmt.Errorf("failed to listen: %w", err)
	}

	// Create gRPC server with auth interceptor
	grpcServer := grpc.NewServer(
		grpc.UnaryInterceptor(s.authInterceptor),
	)
	customer.RegisterCustomerServiceServer(grpcServer, s)

	// Register reflection service for grpcurl
	reflection.Register(grpcServer)

	// Start server
	s.logger.Info(ctx, "Starting gRPC server", map[string]interface{}{
		"port": port,
	})

	go func() {
		if err := grpcServer.Serve(lis); err != nil {
			s.logger.Fatal(ctx, "Failed to serve gRPC", err, nil)
		}
	}()

	// Wait for context cancellation
	<-ctx.Done()
	grpcServer.GracefulStop()
	return nil
}

// authInterceptor is a gRPC interceptor that validates JWT tokens
func (s *Server) authInterceptor(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (interface{}, error) {
	// Skip authentication for health checks
	if info.FullMethod == "/grpc.health.v1.Health/Check" {
		return handler(ctx, req)
	}

	// Get metadata from context
	md, ok := metadata.FromIncomingContext(ctx)
	if !ok {
		return nil, status.Errorf(codes.Unauthenticated, "metadata is not provided")
	}

	// Get authorization token
	authHeader := md.Get("authorization")
	if len(authHeader) == 0 {
		return nil, status.Errorf(codes.Unauthenticated, "authorization token is not provided")
	}

	// Validate token with Keycloak
	token := authHeader[0]
	userID, err := s.validateToken(ctx, token)
	if err != nil {
		return nil, status.Errorf(codes.Unauthenticated, "invalid token: %v", err)
	}

	// Add user ID to context
	newCtx := context.WithValue(ctx, "userID", userID)

	// Call the handler
	return handler(newCtx, req)
}

// validateToken validates a JWT token with Keycloak
func (s *Server) validateToken(ctx context.Context, token string) (string, error) {
	// For simplicity, we'll use a direct HTTP call to Keycloak's userinfo endpoint
	// In a production environment, you might want to use a more robust solution

	// Create a gRPC connection to the auth service
	/*conn, err := grpc.Dial(s.keycloakURL, grpc.WithTransportCredentials(insecure.NewCredentials()))
	if err != nil {
		return "", fmt.Errorf("failed to connect to auth service: %w", err)
	}
	defer conn.Close()*/

	// TODO: Implement actual token validation with Keycloak
	// For now, we'll just extract a user ID from the token for demonstration

	// In a real implementation, you would:
	// 1. Verify the token signature using Keycloak's public key
	// 2. Validate the token claims (expiration, issuer, audience)
	// 3. Extract the user ID from the validated token

	// Mock implementation - extract user ID from token
	// This is NOT secure and should NOT be used in production
	userID := "550e8400-e29b-41d4-a716-446655440000" // Mock user ID

	return userID, nil
}

// AddCustomer implements the AddCustomer RPC
func (s *Server) AddCustomer(ctx context.Context, req *customer.AddCustomerRequest) (*customer.CustomerResponse, error) {
	// Get user ID from context
	userID, ok := ctx.Value("userID").(string)
	if !ok {
		return nil, status.Errorf(codes.Internal, "user ID not found in context")
	}

	// Parse UUID
	customerUUID, err := uuid.Parse(req.Uuid)
	if err != nil {
		return nil, status.Errorf(codes.InvalidArgument, "invalid UUID: %v", err)
	}

	// Verify that the user is adding their own customer record
	if userID != req.Uuid {
		return nil, status.Errorf(codes.PermissionDenied, "cannot add customer record for another user")
	}

	// Create customer entity
	customerEntity := entities.NewCustomer(
		customerUUID,
		req.FirstName,
		req.LastName,
		req.ContactEmail,
		req.ContactPhone,
	)

	// Validate customer data
	if err := customerEntity.Validate(); err != nil {
		return nil, status.Errorf(codes.InvalidArgument, "invalid customer data: %v", err)
	}

	// Try to save customer using Temporal workflow if available
	if s.temporalClient != nil && s.temporalClient.IsConnected() {
		result, err := s.temporalClient.AddCustomer(ctx, customerEntity)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			s.logger.Error(ctx, "Temporal workflow failed, falling back to direct service call", err, map[string]interface{}{
				"workflow": "AddCustomer",
				"uuid":     customerEntity.UUID.String(),
			})
		} else {
			// Return result from workflow
			return &customer.CustomerResponse{
				Uuid:         result.UUID.String(),
				FirstName:    result.FirstName,
				LastName:     result.LastName,
				ContactEmail: result.ContactEmail,
				ContactPhone: result.ContactPhone,
			}, nil
		}
	}

	// Fall back to direct service call if Temporal is not available or failed
	err = s.customerService.AddCustomer(ctx, customerEntity)
	if err != nil {
		s.logger.Error(ctx, "Failed to add customer", err, map[string]interface{}{
			"uuid": customerEntity.UUID.String(),
		})
		return nil, status.Errorf(codes.Internal, "failed to add customer: %v", err)
	}

	return &customer.CustomerResponse{
		Uuid:         customerEntity.UUID.String(),
		FirstName:    customerEntity.FirstName,
		LastName:     customerEntity.LastName,
		ContactEmail: customerEntity.ContactEmail,
		ContactPhone: customerEntity.ContactPhone,
	}, nil
}

// GetCustomer implements the GetCustomer RPC
func (s *Server) GetCustomer(ctx context.Context, req *customer.GetCustomerRequest) (*customer.CustomerResponse, error) {
	// Get user ID from context
	userID, ok := ctx.Value("userID").(string)
	if !ok {
		return nil, status.Errorf(codes.Internal, "user ID not found in context")
	}

	// Parse UUID
	customerUUID, err := uuid.Parse(req.Uuid)
	if err != nil {
		return nil, status.Errorf(codes.InvalidArgument, "invalid UUID: %v", err)
	}

	// Verify that the user is getting their own customer record
	if userID != req.Uuid {
		return nil, status.Errorf(codes.PermissionDenied, "cannot get customer record for another user")
	}

	// Try to get customer using Temporal workflow if available
	if s.temporalClient != nil && s.temporalClient.IsConnected() {
		result, err := s.temporalClient.GetCustomer(ctx, customerUUID)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			s.logger.Error(ctx, "Temporal workflow failed, falling back to direct service call", err, map[string]interface{}{
				"workflow": "GetCustomer",
				"uuid":     customerUUID.String(),
			})
		} else {
			// Return result from workflow
			return &customer.CustomerResponse{
				Uuid:         result.UUID.String(),
				FirstName:    result.FirstName,
				LastName:     result.LastName,
				ContactEmail: result.ContactEmail,
				ContactPhone: result.ContactPhone,
			}, nil
		}
	}

	// Fall back to direct service call if Temporal is not available or failed
	customerEntity, err := s.customerService.GetCustomer(ctx, customerUUID)
	if err != nil {
		s.logger.Error(ctx, "Failed to get customer", err, map[string]interface{}{
			"uuid": customerUUID.String(),
		})
		return nil, status.Errorf(codes.Internal, "failed to get customer: %v", err)
	}

	if customerEntity == nil || customerEntity.IsEmpty() {
		return nil, status.Errorf(codes.NotFound, "customer not found")
	}

	return &customer.CustomerResponse{
		Uuid:         customerEntity.UUID.String(),
		FirstName:    customerEntity.FirstName,
		LastName:     customerEntity.LastName,
		ContactEmail: customerEntity.ContactEmail,
		ContactPhone: customerEntity.ContactPhone,
	}, nil
}

// UpdateCustomer implements the UpdateCustomer RPC
func (s *Server) UpdateCustomer(ctx context.Context, req *customer.UpdateCustomerRequest) (*customer.CustomerResponse, error) {
	// Get user ID from context
	userID, ok := ctx.Value("userID").(string)
	if !ok {
		return nil, status.Errorf(codes.Internal, "user ID not found in context")
	}

	// Parse UUID
	customerUUID, err := uuid.Parse(req.Uuid)
	if err != nil {
		return nil, status.Errorf(codes.InvalidArgument, "invalid UUID: %v", err)
	}

	// Verify that the user is updating their own customer record
	if userID != req.Uuid {
		return nil, status.Errorf(codes.PermissionDenied, "cannot update customer record for another user")
	}

	// Create customer entity
	customerEntity := entities.NewCustomer(
		customerUUID,
		req.FirstName,
		req.LastName,
		req.ContactEmail,
		req.ContactPhone,
	)

	// Validate customer data
	if err := customerEntity.Validate(); err != nil {
		return nil, status.Errorf(codes.InvalidArgument, "invalid customer data: %v", err)
	}

	// Try to update customer using Temporal workflow if available
	if s.temporalClient != nil && s.temporalClient.IsConnected() {
		result, err := s.temporalClient.UpdateCustomer(ctx, customerEntity)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			s.logger.Error(ctx, "Temporal workflow failed, falling back to direct service call", err, map[string]interface{}{
				"workflow": "UpdateCustomer",
				"uuid":     customerEntity.UUID.String(),
			})
		} else {
			// Return result from workflow
			return &customer.CustomerResponse{
				Uuid:         result.UUID.String(),
				FirstName:    result.FirstName,
				LastName:     result.LastName,
				ContactEmail: result.ContactEmail,
				ContactPhone: result.ContactPhone,
			}, nil
		}
	}

	// Fall back to direct service call if Temporal is not available or failed
	err = s.customerService.UpdateCustomer(ctx, customerEntity)
	if err != nil {
		if err == entities.ErrCustomerNotFound {
			return nil, status.Errorf(codes.NotFound, "customer not found")
		}

		s.logger.Error(ctx, "Failed to update customer", err, map[string]interface{}{
			"uuid": customerEntity.UUID.String(),
		})
		return nil, status.Errorf(codes.Internal, "failed to update customer: %v", err)
	}

	return &customer.CustomerResponse{
		Uuid:         customerEntity.UUID.String(),
		FirstName:    customerEntity.FirstName,
		LastName:     customerEntity.LastName,
		ContactEmail: customerEntity.ContactEmail,
		ContactPhone: customerEntity.ContactPhone,
	}, nil
}

// ListCustomers implements the ListCustomers RPC
func (s *Server) ListCustomers(ctx context.Context, req *customer.ListCustomersRequest) (*customer.ListCustomersResponse, error) {
	// Get user ID from context
	userID, ok := ctx.Value("userID").(string)
	if !ok {
		return nil, status.Errorf(codes.Internal, "user ID not found in context")
	}

	// Only allow admin users to list all customers
	// In a real implementation, you would check if the user has admin privileges
	if userID != "admin" {
		return nil, status.Errorf(codes.PermissionDenied, "only admin users can list all customers")
	}

	// Try to list customers using Temporal workflow if available
	if s.temporalClient != nil && s.temporalClient.IsConnected() {
		results, err := s.temporalClient.ListCustomers(ctx)
		if err != nil {
			// If Temporal fails, fall back to direct service call
			s.logger.Error(ctx, "Temporal workflow failed, falling back to direct service call", err, map[string]interface{}{
				"workflow": "ListCustomers",
			})
		} else {
			// Convert results to response
			response := &customer.ListCustomersResponse{
				Customers: make([]*customer.CustomerResponse, len(results)),
			}
			for i, customerEntity := range results {
				response.Customers[i] = &customer.CustomerResponse{
					Uuid:         customerEntity.UUID.String(),
					FirstName:    customerEntity.FirstName,
					LastName:     customerEntity.LastName,
					ContactEmail: customerEntity.ContactEmail,
					ContactPhone: customerEntity.ContactPhone,
				}
			}
			return response, nil
		}
	}

	// Fall back to direct service call if Temporal is not available or failed
	customers, err := s.customerService.ListCustomers(ctx)
	if err != nil {
		s.logger.Error(ctx, "Failed to list customers", err, nil)
		return nil, status.Errorf(codes.Internal, "failed to list customers: %v", err)
	}

	// Convert results to response
	response := &customer.ListCustomersResponse{
		Customers: make([]*customer.CustomerResponse, len(customers)),
	}
	for i, customerEntity := range customers {
		response.Customers[i] = &customer.CustomerResponse{
			Uuid:         customerEntity.UUID.String(),
			FirstName:    customerEntity.FirstName,
			LastName:     customerEntity.LastName,
			ContactEmail: customerEntity.ContactEmail,
			ContactPhone: customerEntity.ContactPhone,
		}
	}
	return response, nil
}
