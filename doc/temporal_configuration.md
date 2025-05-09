# Temporal Configuration Guide

This document explains how to configure Temporal for new microservices in the SaaS B2B Starter Kit.

## Namespaces

Temporal uses namespaces to isolate different workflows and activities. Each microservice should have its own namespace.

### Creating a New Namespace

To create a new namespace for your microservice:

1. Add the namespace configuration to `infra/temporal/dynamicconfig/docker.yaml`:

```yaml
frontend.clientNamespaceLimit:
  - value: 1000
    constraints: {}
    namespaces: your-namespace
frontend.clientNamespaceCountPerInstance:
  - value: 1000
    constraints: {}
    namespaces: your-namespace
frontend.clientRPS:
  - value: 1000
    constraints: {}
    namespaces: your-namespace
frontend.clientVisibilityRPS:
  - value: 100
    constraints: {}
    namespaces: your-namespace
history.defaultWorkflowTaskTimeout:
  - value: 10s
    constraints: {}
    namespaces: your-namespace
workflow.defaultWorkflowExecutionTimeout:
  - value: 60s
    constraints: {}
    namespaces: your-namespace
workflow.defaultWorkflowRunTimeout:
  - value: 60s
    constraints: {}
    namespaces: your-namespace
workflow.defaultActivityStartToCloseTimeout:
  - value: 30s
    constraints: {}
    namespaces: your-namespace
```

2. Create a function to register the namespace using the Go SDK:

```go
// RegisterNamespace registers a new namespace with Temporal
func RegisterNamespace(ctx context.Context, temporalAddress, namespace string) error {
    // Create a client to the frontend service
    c, err := client.Dial(client.Options{
        HostPort: temporalAddress,
    })
    if err != nil {
        return fmt.Errorf("failed to create Temporal client: %w", err)
    }
    defer c.Close()

    // Set retention period to 1 day (minimum allowed)
    retentionDays := int32(1)

    // Register the namespace
    registerRequest := &workflowservice.RegisterNamespaceRequest{
        Namespace:                        namespace,
        Description:                      "Namespace for your microservice workflows",
        OwnerEmail:                       "admin@example.com",
        WorkflowExecutionRetentionPeriod: &retentionDays,
    }

    _, err = c.WorkflowService().RegisterNamespace(ctx, registerRequest)
    if err != nil {
        // Check if the error is because the namespace already exists
        if err.Error() == "Namespace already exists" {
            log.Printf("Namespace %s already exists", namespace)
            return nil
        }
        return fmt.Errorf("failed to register namespace: %w", err)
    }

    log.Printf("Namespace %s registered successfully", namespace)
    return nil
}
```

3. Update your microservice's Docker configuration to use the new namespace:

```yaml
environment:
  - TEMPORAL_ADDRESS=temporal:7233
  - TEMPORAL_NAMESPACE=your-namespace
  - TEMPORAL_TASK_QUEUE=your-microservice-task-queue
```

## Workflows and Activities

### Defining Workflows

Workflows should be defined in your microservice's `internal/workflows` directory:

```go
// YourWorkflow is the workflow for your operation
func YourWorkflow(ctx workflow.Context, input YourInputType) (*YourOutputType, error) {
    logger := workflow.GetLogger(ctx)
    logger.Info("YourWorkflow started", "input", input)

    // Set workflow timeout
    ctx = workflow.WithActivityOptions(ctx, workflow.ActivityOptions{
        StartToCloseTimeout: 10 * time.Second,
        RetryPolicy: &workflow.RetryPolicy{
            InitialInterval:    time.Second,
            BackoffCoefficient: 2.0,
            MaximumInterval:    time.Minute,
            MaximumAttempts:    3,
        },
    })

    // Execute the activity
    var result YourOutputType
    err := workflow.ExecuteActivity(ctx, "YourActivity", input).Get(ctx, &result)
    if err != nil {
        logger.Error("YourWorkflow failed", "error", err)
        return nil, err
    }

    logger.Info("YourWorkflow completed successfully", "result", result)
    return &result, nil
}
```

### Defining Activities

Activities should be defined in your microservice's `internal/workflows` directory:

```go
// YourActivity is the activity for your operation
func (a *YourActivities) YourActivity(ctx context.Context, input YourInputType) (*YourOutputType, error) {
    logger := activity.GetLogger(ctx)
    logger.Info("YourActivity started", "input", input)

    // Implement your activity logic here
    // ...

    logger.Info("YourActivity completed successfully", "result", result)
    return &result, nil
}
```

### Registering Workflows and Activities

Register your workflows and activities in your microservice's worker:

```go
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
    w.RegisterWorkflow(YourWorkflow)

    // Create and register activities
    activities := NewYourActivities(config.YourService)
    w.RegisterActivity(activities.YourActivity)

    // Start worker
    err = w.Start()
    if err != nil {
        c.Close()
        return nil, fmt.Errorf("failed to start worker: %w", err)
    }

    log.Printf("Temporal worker started. Namespace: %s, Task Queue: %s", config.Namespace, config.TaskQueue)
    return c, nil
}
```

## Testing Workflows

You can test your workflows using the Go SDK:

```go
// Start a workflow
workflowOptions := client.StartWorkflowOptions{
    ID:        "your-workflow-id",
    TaskQueue: "your-microservice-task-queue",
}

input := YourInputType{Key: "value"}
run, err := c.ExecuteWorkflow(context.Background(), workflowOptions, "YourWorkflow", input)
if err != nil {
    log.Fatalf("Failed to start workflow: %v", err)
}

// Get the workflow result
var result YourOutputType
if err := run.Get(context.Background(), &result); err != nil {
    log.Fatalf("Workflow execution failed: %v", err)
}

// Query workflow status
resp, err := c.DescribeWorkflowExecution(context.Background(), "your-workflow-id", "")
if err != nil {
    log.Fatalf("Failed to describe workflow: %v", err)
}

// List workflows
listRequest := &workflowservice.ListWorkflowExecutionsRequest{
    Namespace: "your-namespace",
    Query:     "WorkflowType = 'YourWorkflow'",
}
resp, err := c.ListWorkflow(context.Background(), listRequest)
if err != nil {
    log.Fatalf("Failed to list workflows: %v", err)
}
```

You can also use the Temporal Web UI to test and monitor workflows.

## Monitoring Workflows

You can monitor your workflows using the Temporal UI at http://localhost:8081.

## Troubleshooting

If you encounter issues with Temporal:

1. Check the Temporal logs:
```bash
docker logs temporal
```

2. Check the Temporal UI for workflow errors:
```
http://localhost:8081
```

3. Verify your namespace is registered using the Go SDK:
```go
c, err := client.Dial(client.Options{
    HostPort: temporalAddress,
})
if err != nil {
    log.Fatalf("Failed to create Temporal client: %v", err)
}
defer c.Close()

resp, err := c.WorkflowService().DescribeNamespace(context.Background(), &workflowservice.DescribeNamespaceRequest{
    Namespace: "your-namespace",
})
if err != nil {
    log.Fatalf("Failed to describe namespace: %v", err)
}
log.Printf("Namespace info: %+v", resp.NamespaceInfo)
```

4. Check your microservice's connection to Temporal:
```bash
docker logs your-microservice | grep -i temporal
```
