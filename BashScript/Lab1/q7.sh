#!/bin/bash

if [ $# -eq 1 ]
then 
    if [ -d "${!#}" ]
    then
        echo "this is directory " 
        stat -c "%A" "${!#}"
    elif [ -f "${!#}" ]
    then
        echo "this is file " 
        stat -c "%A" "${!#}"
    else
        echo "Invalid type "
    fi
else
echo "Invalid parameter "
fi