#!/bin/bash

declare -i counter
declare -i zar
declare -i average

declare -a arr
counter=0
average=0

while true;do
    echo "Please choose an option:"
    select xar in "add number" "print average" "exit"; do
        case $REPLY in
            1) read -p "enter your number: " zar
                arr[$counter]=$zar
                counter=$counter+1
                ;;
            2)  average=0
                for jar in "${arr[@]}";do
                    #echo "jar = ${jar}"
                    average=$average+$jar
                done
                #echo "${average}"
                average=$average/$counter
                echo "the average is ${average}"
                ;;
            3) exit 0 ;;
        esac
        break
    done
done


