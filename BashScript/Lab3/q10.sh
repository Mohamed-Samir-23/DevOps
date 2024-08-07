#!/bin/bash

echo "User-Group Report"
echo "-----------------------------------"

awk -F: '
BEGIN {
  # Read the /etc/group file to get group names
  while ((getline < "/etc/group") > 0) {
    split($0, fields, ":")
    groupname[fields[3]] = fields[1]
  }
  close("/etc/group")
}
{
  # Collect users under each group
  users[$4] = users[$4] "\n" $1
}
END {
  for (gid in users) {
    print "***************************************" groupname[gid] "Name: " users[gid]
  }
}
' /etc/passwd
