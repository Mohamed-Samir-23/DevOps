#!/bin/bash
if [ $# -eq 1 ]
then 
    echo "list directory ... "
    ls "${!#}"
elif [ $# -lt 1 ]
then
    echo "list current directory"
    ls 
else
    echo "too much parameters"
fi