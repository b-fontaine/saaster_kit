FROM golang:1.22-alpine AS builder

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o client_manager ./cmd/main.go

# Use a small alpine image
FROM alpine:latest

# Install necessary packages
RUN apk --no-cache add ca-certificates tzdata curl bash

WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/client_manager .

# Copy migrations
COPY --from=builder /app/migrations ./migrations

# Copy scripts
COPY --from=builder /app/scripts ./scripts

# Expose port
EXPOSE 8080

# Run the application
CMD ["./client_manager"]
