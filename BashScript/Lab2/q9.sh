#!/bin/bash
declare -i var
declare -i counter
declare -a myarray
read -p "enter number of element : " var
counter=0

while [ $counter -lt $var ];do

    read -p "arr[${counter}]= " num

    myarray[${counter}]=$num

    counter=$counter+1
done

for xar in "${myarray[@]}"; do
    echo $xar
done
