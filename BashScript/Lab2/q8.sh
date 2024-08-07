#!/bin/bash

while true; do
    echo "Please choose an option:"
    select option in "ls" "ls -a" "Exit"; do
        case $REPLY in
            1) ls ;;
            2) ls -a ;;
            3) exit 0 ;;
            *) echo "Invalid option. Please try again." ;;
        esac
        break
    done
done
