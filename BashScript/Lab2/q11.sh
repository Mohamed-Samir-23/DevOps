#!/bin/bash

square()
{
    local x=$1
    echo $((x*x))
}


if [ $# -eq 1 ];then
    result=$(square $1)
    echo "the square $1 is ${result}"
else
    echo "Invalid argument"
fi

