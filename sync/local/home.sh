#!/bin/bash

shopt -s dotglob

# Set paths
git_repo="$(git rev-parse --show-toplevel 2>/dev/null)/home"
local_dir="$(echo ~)"

# Iterate through each file in the git repository directory
for git_file in "$git_repo"/*; do
    # Get just the filename
    filename=$(basename "$git_file")
    local_file="$local_dir/$filename"

    if [ -e "$local_file" ]; then
        # File exists, show diff and wait for user confirmation
        echo "File $filename exists locally. Showing diff:"
        diff_output=$(diff "$git_file" "$local_file")

        if [ -n "$diff_output" ]; then
            echo "$diff_output"
            read -p "Do you want to overwrite the local file? (y/n) " choice
            if [ "$choice" == "y" ]; then
                cp "$git_file" "$local_file"
                echo "File $filename has been overwritten."
            else
                echo "File $filename was not changed."
            fi
        else
            echo "Files are identical. No action taken."
        fi
    else
        # File does not exist, copy it
        cp "$git_file" "$local_file"
        echo "File $filename has been copied to $local_dir."
    fi
done

shopt -u dotglob
