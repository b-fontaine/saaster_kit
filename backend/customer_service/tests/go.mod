module github.com/b-fontaine/saaster_kit/backend/customer_service/tests

go 1.22

require (
	github.com/b-fontaine/saaster_kit/backend/customer_service v0.0.0
	github.com/cucumber/godog v0.13.0
	github.com/google/uuid v1.4.0
	github.com/lib/pq v1.10.9
	github.com/stretchr/testify v1.8.4
	github.com/testcontainers/testcontainers-go v0.27.0
	github.com/testcontainers/testcontainers-go/modules/postgres v0.27.0
)

replace github.com/b-fontaine/saaster_kit/backend/customer_service => ../
