#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <source_file_or_directory> <username> <ip_address>"
    exit 1
fi

source_path="$1"
username="$2"
ip_address="$3"

echo "Copying '$source_path' to $username@$ip_address:~ using RSYNC..."
rsync -avz "$source_path" "$username@$ip_address:~"

if [ $? -eq 0 ]; then
    echo "Successfully copied '$source_path' to $username@$ip_address:~"
else
    echo "Error: Failed to copy '$source_path' using RSYNC."
    exit 1
fi