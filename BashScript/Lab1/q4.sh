#!/bin/bash
if [ $# -eq 1 ]
then 
    echo "go to directory ... "
    cd "${!#}"
elif [ $# -lt 1 ]
then
    echo "go to home"
    cd "$HOME" || echo "Failed to change directory"
else
    echo "too much parameters"
fi