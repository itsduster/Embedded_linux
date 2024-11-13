#!/bin/bash

# Source the file lookup script to get the file path
echo 
echo "The file needs to be searched....."
source ./file_lookup.sh

LOG_FILE="access_log.txt"  # Log file for recording access attempts

# Check if the file exists and if it's already protected
if [ -n "$PROTECTED_FILE_PATH" ]; then
    echo "Proceeding with file: $PROTECTED_FILE_PATH"
    
    # Check if file is already owned by root and has 600 permissions
    if [ "$(stat -c '%U' "$PROTECTED_FILE_PATH")" = "root" ] && [ "$(stat -c '%a' "$PROTECTED_FILE_PATH")" = "600" ]; then
        echo "The file is already protected with sudo ownership and restricted permissions."
    else
        echo "Adding Authentication to $PROTECTED_FILE_PATH... Please Wait"
        
        # Protect the file by changing ownership and permissions
        sudo chown root:root "$PROTECTED_FILE_PATH"
        sudo chmod 600 "$PROTECTED_FILE_PATH"
        
        # Create an alias for accessing the file and log each access attempt
        ALIAS_COMMAND="alias access_file='echo \"Accessing protected file...\"; sudo cat \"$PROTECTED_FILE_PATH\"; echo \"\$(date): Accessed $PROTECTED_FILE_PATH\" >> $LOG_FILE'"
        
        # Add the alias to .bashrc if it doesn't already exist
        if ! grep -Fxq "$ALIAS_COMMAND" ~/.bashrc; then
            echo "$ALIAS_COMMAND" >> ~/.bashrc
            echo "Alias 'access_file' added to .bashrc. Use 'access_file' command to view the file's contents."
        else
            echo "Alias 'access_file' already exists in .bashrc."
        fi

        # Reload .bashrc to make the alias available in the current session
        source ~/.bashrc
    fi
else
    echo "Sorry, the file isn't available."
fi
