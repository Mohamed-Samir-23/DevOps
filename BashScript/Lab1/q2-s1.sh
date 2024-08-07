#!/bin/bash 
export x=5
echo "first way"
./q2-s2.sh
unset x
x=5
echo "second way"
./q2-s3.sh $x