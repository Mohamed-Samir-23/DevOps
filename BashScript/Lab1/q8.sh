#!/bin/bash
read -p "Please enter your logname: " logname

echo "Full info about files and directories in home directory:"
ls -la /home/$logname

echo "Copying files to /tmp directory:"
cp -r /home/$logname/* /tmp/

echo "Current process status:"
ps -u $logname
