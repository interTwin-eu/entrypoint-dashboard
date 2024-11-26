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

# Run docker-compose up
echo "Starting services with $DOCKER_COMPOSE..."
$DOCKER_COMPOSE up -d

echo "Services started successfully."
