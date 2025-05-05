FROM golang:1.22-alpine AS builder

WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download dependencies
RUN go mod download

# Copy source code
COPY . .

# Build the application
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o user_manager ./cmd/main.go

# Use a minimal alpine image
FROM alpine:3.19

RUN apk --no-cache add ca-certificates netcat-openbsd curl

# Install Temporal CLI
# RUN curl -sSf https://temporal.download/cli.sh | sh -s -- -b /usr/local/bin

WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/user_manager .

# Copy initialization scripts
COPY scripts/init-temporal.sh /app/
# RUN chmod +x /app/init-temporal.sh

# Expose port
EXPOSE 8080

# Command to run
# CMD ["/bin/sh", "-c", "/app/init-temporal.sh && ./user_manager"]
CMD ["/bin/sh", "-c", "./user_manager"]
