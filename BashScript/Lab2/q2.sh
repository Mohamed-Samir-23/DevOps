#!/bin/bash

read -p "enter your string: " var

if [[ $var =~ ^[A-Z]+$ ]]; then
    echo "Upper Cases"
elif [[ $var =~ ^[a-z]+$ ]]; then
    echo "Lower Cases"
elif [[ $var =~ ^[0-9]+$ ]]; then
    echo "Numbers"
elif [[ -z $var ]]; then
    echo "Nothing"
else
    echo "Mix"
fi