#!/bin/bash

# Enable dotglob to include hidden files in the expansion of *
shopt -s dotglob

# remember original working directory
current_dir="$(pwd)"

# Set paths
git_repo="$(git rev-parse --show-toplevel 2>/dev/null)/home"
local_dir="$(echo ~)"

# Change to the Git repository directory
cd "$git_repo" || { echo "Failed to change directory to $git_repo"; exit 1; }

# Iterate through each file in the Git repository
for git_file in "$git_repo"/*; do
    # Extract the filename
    filename=$(basename "$git_file")
    local_file="$local_dir/$filename"

    if [ -e "$local_file" ]; then
        # Local file exists, show diff and wait for user confirmation
        echo "File $filename exists in both locations. Showing diff:"
        diff_output=$(diff "$local_file" "$git_file")

        if [ -n "$diff_output" ]; then
            echo "$diff_output"
            read -p "Do you want to overwrite the repository file? (y/n) " choice
            if [ "$choice" == "y" ]; then
                cp "$local_file" "$git_file"
                echo "File $filename has been overwritten in the repository."
            else
                echo "File $filename was not changed."
            fi
        else
            echo "Files are identical. No action taken."
        fi
    else
        echo "File $filename does not exist locally. No action taken."
    fi
done

shopt -u dotglob
cd $current_dir
