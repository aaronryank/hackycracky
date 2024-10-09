#!/bin/bash
# Copy from remote to local

# Enable dotglob to include hidden files in the expansion of *
shopt -s dotglob

# Set paths
git_dir="$(git rev-parse --show-toplevel 2>/dev/null)/home"
local_dir="$(echo ~)"

# Iterate through each file in the Git repository
for git_file in "$git_dir"/*; do
    # get base name of repo file and full path of local file
    filename=$(basename "$git_file")
    local_file="$local_dir/$filename"

    if [ -f "$local_file" ]; then
        # Local file exists, show diff and wait for approval
        echo "File $filename exists locally. Showing diff:"
        diff_output=$(diff "$git_file" "$local_file")

        if [ -n "$diff_output" ]; then
            echo "$diff_output"
            read -p "Do you want to overwrite the local file? (y/n) " choice
            if [ "$choice" == "y" ]; then
                cp "$git_file" "$local_file"
                echo "File $filename has been overwritten locally."
            else
                echo "File $filename was not changed locally."
            fi
        else
            echo "Files are identical. No action taken."
        fi
    elif [ -d "$git_file" ]; then
        # don't feel like writing a whole recursive function
        read -p "$filename is a directory. There is nothing currently implemented to display file diffs; cp -i will be used for overwrite protection. Proceed? (y/n) " choice
        if [ "$choice" == "y" ]; then
            cp -ir "$git_file" "$local_dir/"
            echo "Directory $filename has been cloned."
        fi
    else
        # File does not exist, copy it
        cp "$git_file" "$local_file"
        echo "File $filename has been copied to $local_dir."
    fi
done

shopt -u dotglob
