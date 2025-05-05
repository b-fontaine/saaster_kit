#!/bin/sh

# Wait for Temporal to be ready
echo "Waiting for Temporal server to be ready..."
until nc -z temporal 7233; do
  sleep 1
done
echo "Temporal server is ready!"

# Create the user-manager namespace if it doesn't exist
echo "Creating user-manager namespace in Temporal..."
tctl --address temporal:7233 namespace describe user-manager > /dev/null 2>&1
if [ $? -ne 0 ]; then
  tctl --address temporal:7233 namespace register user-manager \
    --retention 1 \
    --description "Namespace for user management service"
  echo "Namespace user-manager created successfully!"
else
  echo "Namespace user-manager already exists."
fi

# Register workflow types
echo "Registering workflow types..."
# This is handled automatically by the worker when it starts

echo "Temporal initialization completed!"
