.PHONY: build test run clean docker-build

# Build variables
BINARY_NAME=client_manager
MAIN_FILE=cmd/main.go

# Docker variables
DOCKER_IMAGE=client_manager:latest

# Build the application
build:
	go build -o $(BINARY_NAME) $(MAIN_FILE)

# Run the application
run: build
	./$(BINARY_NAME)

# Run tests
test:
	cd tests && go test -v

# Clean build artifacts
clean:
	rm -f $(BINARY_NAME)
	go clean

# Build Docker image
docker-build:
	docker build -t $(DOCKER_IMAGE) .

# Run migrations
migrate-up:
	go run -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate \
		-path ./migrations \
		-database "postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=disable" \
		up

# Rollback migrations
migrate-down:
	go run -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate \
		-path ./migrations \
		-database "postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=disable" \
		down 1

# Create a new migration
migrate-create:
	@read -p "Enter migration name: " name; \
	go run -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate create -ext sql -dir ./migrations -seq $$name
