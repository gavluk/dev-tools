#!/bin/bash

#########
# USAGE:
#
## Will change given settings.xml file:
# ./mvn-add-settings-server.sh SERVER1 login password /path/to/settings.xml
#
## Will produce STDOUT updated settings.xml
# cat /path/to/settings.xml | ./mvn-add-settings-server.sh SERVER1 login password

ID=$1
USERNAME=$2
PASSWORD=$3
FILE=$4

if [[ -z $ID ]]; then >&2 echo "First parameter must be a server ID"; exit 1; fi
if [[ -z $USERNAME ]]; then >&2 echo "Second parameter must be a username"; exit 1; fi
if [[ -z $PASSWORD ]]; then >&2 echo "Third parameter must be a password"; exit 1; fi
if [[ -n $FILE && ! -f $FILE ]]; then >&2 echo "Fourth argument is not existing file"; exit 1; fi

NEW_SERVER="\n<server>\n"
NEW_SERVER="${NEW_SERVER}\t<id>${ID}</id>\n"
NEW_SERVER="${NEW_SERVER}\t<username>${USERNAME}</username>\n"
NEW_SERVER="${NEW_SERVER}\t<password>${PASSWORD}</password>\n"
NEW_SERVER="${NEW_SERVER}</server>\n"

if [[ -z $FILE ]]; then
  sed "s#<servers>#<servers>$NEW_SERVER#" <&0
else
  sed -i "s#<servers>#<servers>$NEW_SERVER#" $FILE
fi
