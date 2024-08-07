#!/bin/bash 

#echo ${@:1:$#-1} --> list all element without last arg
#echo "${!#}" --> print last arg

if [ $# -eq 2 ]
then

    if [ -e $1 -a -e $2 ]
    then
        cat $1 > $2
        echo "copy is done"
    fi

elif [ $# -gt 2 ]
then 
    if [ -d "${!#}" ]
    then
        xar=1

        for var in "${@:1:$#-1}";do
            if [ -e "$var" ]
            then
                echo "$var is exist"
            else
                echo "$var is not exist"
                xar=0
            fi
        done

        if [ $xar -eq 1 ]
        then 
            echo "ready for copy"

            for var in "${@:1:$#-1}";do
                cp  "$var" "${!#}"
            done

            echo "copy is done"

        else
            echo "copy not done"
        fi

    else
        echo "Error: The last argument is not a directory"
    fi
else
    echo "error"
fi