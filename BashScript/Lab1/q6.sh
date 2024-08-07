#!/bin/bash

# Initialize options
long_format=""
all_entries=""
dir_only=""
inode=""
recursive=""

# Parse options
while getopts "ladiR" opt; do
  case ${opt} in
    l) long_format="-l" ;;
    a) all_entries="-a" ;;
    d) dir_only="-d" ;;
    i) inode="-i" ;;
    R) recursive="-R" ;;
    \?)
      echo "Invalid option"
      exit 1
      ;;
  esac
done

ls_command="ls $long_format $all_entries $dir_only $inode $recursive"

if [ "$#" -eq 0 ]; then
  $ls_command
else
  for dir in "$@"; do
    $ls_command "$dir"
  done
fi
