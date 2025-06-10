#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

target_directory="$1"

if [ ! -d "$target_directory" ]; then
    echo "Directory '$target_directory' does not exist. Creating it now..."
    mkdir -p "$target_directory"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create directory '$target_directory'."
        exit 1
    fi
    echo "Directory '$target_directory' created successfully."
fi

echo "Generating SSH key pair in '$target_directory'..."
ssh-keygen -t rsa -b 4096 -f "$target_directory/id_rsa" -N ""

if [ $? -eq 0 ]; then
    echo "SSH key pair created successfully:"
    echo "Public key: $target_directory/id_rsa.pub"
    echo "Private key: $target_directory/id_rsa"
else
    echo "Error: Failed to generate SSH key pair."
    exit 1
fi