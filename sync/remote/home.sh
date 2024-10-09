#!/bin/bash
# Copy from local to remote

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
        echo "diff for $local_file and $git_file:"
        diff_output=$(diff "$local_file" "$git_file")

        if [ -n "$diff_output" ]; then
            echo "$diff_output"
            read -p "Do you want to overwrite the repository file? (y/n) " choice
            if [ "$choice" == "y" ]; then
                cp "$local_file" "$git_file"
                echo "File $filename has been overwritten in the repository."
            else
                echo "File $filename was not changed in the repository."
            fi
        else
            echo "Files are identical. No action taken."
        fi
    elif [ -d "$local_file" ]; then
        # don't feel like writing a whole recursive function
        read -p "$filename is a directory. There is nothing currently implemented to display file diffs; cp -i will be used for overwrite protection. Proceed? (y/n) " choice
        if [ "$choice" == "y" ]; then
            cp -ir "$local_file" "$git_dir/"
            echo "Directory $filename has been cloned."
        fi
    else
        # we're not cloning the entire home directory, just what has been specified to belong in repo
        echo "File $filename does not exist locally. No action taken."
    fi
done

shopt -u dotglob
