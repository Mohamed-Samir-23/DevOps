#!/bin/bash

backup_dir="$HOME/backup"

# Create the backup directory if it doesn't exist
mkdir -p "$backup_dir"

for file in "$HOME"/*; do
    if [[ -f $file ]]; then
        cp "$file" "$backup_dir"
    fi
done

echo "Backup completed."