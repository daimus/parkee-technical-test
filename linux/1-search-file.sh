#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory> <file_extension>"
    exit 1
fi

directory="$1"
extension="$2"

if [ ! -d "$directory" ]; then
    echo "Error: Directory '$directory' not found."
    exit 1
fi

echo "Searching for files with extension '.$extension' in '$directory'..."
find "$directory" -name "*.$extension" -type f -print | while read -r file; do
    basename "$file"
done