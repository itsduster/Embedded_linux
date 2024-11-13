#!/bin/bash

# Look for the file in the current directory and its subdirectories
find_file() {
    echo -n "Enter the filename: "
    read filename

    # Find the file and store the path
    file_found=$(find . -type f -name "$filename")

    if [ -n "$file_found" ]; then
        echo "File found: $file_found"
        export PROTECTED_FILE_PATH="$file_found"
    else
        echo "File not found."
        export PROTECTED_FILE_PATH=""
    fi
}

find_file
