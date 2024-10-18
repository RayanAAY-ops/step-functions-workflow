#!/bin/bash

# Function to create a directory if it doesn't exist
create_dir() {
  if [ ! -d "$1" ]; then
    mkdir -p "$1"
    echo "Created directory: $1"
  fi
}

# Function to create a file if it doesn't exist
create_file() {
  if [ ! -f "$1" ]; then
    touch "$1"
    echo "Created file: $1"
  fi
}


# Root of the project
ROOT_DIR="."

# Create the root directory
create_dir $ROOT_DIR

# Create the scripts folder
create_dir "$ROOT_DIR/scripts"

# Create main Terraform files
create_file "$ROOT_DIR/main.tf"
create_file "$ROOT_DIR/variables.tf"
create_file "$ROOT_DIR/outputs.tf"
create_file "$ROOT_DIR/terraform.tfvars"
create_file "$ROOT_DIR/backend.tf"
create_file "$ROOT_DIR/provider.tf"
create_file "$ROOT_DIR/README.md"
create_file "$ROOT_DIR/Makefile"
create_file "$ROOT_DIR/.gitlab-ci.yml"

# Final message
echo "Terraform project structure created successfully!"