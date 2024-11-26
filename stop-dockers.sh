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

# Stop services
echo "Stopping services with $DOCKER_COMPOSE..."
$DOCKER_COMPOSE down

# Remove unused images and prune system
echo "Removing unused images and pruning system..."
docker image prune -af
docker system prune -f

echo "Services stopped and system cleaned."
