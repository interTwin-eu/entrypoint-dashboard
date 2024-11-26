#!/bin/bash

# Check for docker compose command
if docker compose version > /dev/null 2>&1; then
    DOCKER_COMPOSE="docker compose"
elif docker-compose version > /dev/null 2>&1; then
    DOCKER_COMPOSE="docker-compose"
else
    echo "Error: Neither 'docker compose' nor 'docker-compose' found."
    exit 1
fi

# Prompt user for CORS Anywhere IP/Domain
echo "Enter the IP/Domain and port for CORS Anywhere (e.g., http://example.com:8086):"
read -r CORS_HOST

if [ -z "$CORS_HOST" ]; then
    CORS_HOST="http://localhost:8086"
    echo "No input provided. Defaulting to: $CORS_HOST"
else
    echo "Using CORS Anywhere at: $CORS_HOST"
fi

# Replace <http://your-host-o-domain:port> in config.yml
echo "Configuring Homer..."
if [ ! -f "./config.yml" ]; then
    echo "Error: config.yml not found in the root directory."
    exit 1
fi

sed "s|<http://your-host-o-domain:port>|$CORS_HOST|g" ./config.yml > ./assets/config.yml

# Check if the replacement was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to configure Homer."
    exit 1
fi

echo "Homer configuration updated successfully."

# Start Docker Compose services
echo "Starting services with $DOCKER_COMPOSE..."
$DOCKER_COMPOSE up -d

if [ $? -eq 0 ]; then
    echo "Services started successfully."
else
    echo "Error: Failed to start services."
    exit 1
fi
