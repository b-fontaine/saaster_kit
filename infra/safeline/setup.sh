#!/bin/bash

# Create data directory
mkdir -p data/resources/detector

# Copy detector configuration
cp detector.yml data/resources/detector/

# Start SafeLine
docker-compose up -d

echo "SafeLine has been started. Management UI is available at https://localhost:9443"
echo "Default credentials: admin / admin"
echo "Please change the password after first login"
