#!/bin/bash

set -e
trap 'echo "An error occurred. Exiting..."; exit 1;' ERR

#Verify Docker is installed
echo "Verifying Docker installation..."
if command -v docker &> /dev/null
then
    echo "Docker is already installed"
    exit 0
fi

#install dependencies
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

# Add Docker's official GPG key:
echo "Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repository
echo "Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null 2>> error.log

# Update package list
sudo apt-get update

# Install Docker packages
echo "Installing Docker packages..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Verify Docker installation
echo "Verifying Docker installation..."
if ! command -v docker &> /dev/null
then
    echo "Docker installation failed"
    exit 1
else
    echo "Docker installed successfully"
    exit 0
fi