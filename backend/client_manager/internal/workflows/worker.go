package workflows

import (
	"fmt"
	"log"

	"github.com/b-fontaine/saaster_kit/backend/client_manager/internal/ports/in"
	"go.temporal.io/sdk/client"
	"go.temporal.io/sdk/worker"
)

// WorkerConfig holds the configuration for the Temporal worker
type WorkerConfig struct {
	TemporalAddress string
	Namespace       string
	TaskQueue       string
	ClientService   in.ClientService
}

// StartWorker starts a Temporal worker
func StartWorker(config WorkerConfig) (client.Client, error) {
	// Create Temporal client
	c, err := client.Dial(client.Options{
		HostPort:  config.TemporalAddress,
		Namespace: config.Namespace,
	})
	if err != nil {
		return nil, fmt.Errorf("failed to create Temporal client: %w", err)
	}

	// Create worker
	w := worker.New(c, config.TaskQueue, worker.Options{})

	// Register workflows
	w.RegisterWorkflow(AddClientWorkflow)
	w.RegisterWorkflow(GetClientWorkflow)

	// Create and register activities
	activities := NewClientActivity(config.ClientService)
	w.RegisterActivity(activities.AddClientActivity)
	w.RegisterActivity(activities.GetClientActivity)

	// Start worker
	err = w.Start()
	if err != nil {
		c.Close()
		return nil, fmt.Errorf("failed to start worker: %w", err)
	}

	log.Printf("Temporal worker started. Namespace: %s, Task Queue: %s", config.Namespace, config.TaskQueue)
	return c, nil
}
