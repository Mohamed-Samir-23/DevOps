#!/bin/bash

mail_body="./mtemplate"

for user in $(cut -d: -f1 /etc/passwd); do
    mail -s "Subject" "$user" < "$mail_body"
done