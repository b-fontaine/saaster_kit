#!/bin/bash
set -e

# Run the Elasticsearch setup script in the background
./scripts/setup-elasticsearch.sh &

# Start the main application
exec ./client_manager
