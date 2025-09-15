#!/bin/bash

CMD=$2
TIMEOUT=$1
INTERVAL=5

if [ -z $CMD ] || [ -z $TIMEOUT ]; then
	cat <<EOF
Usage: retry-until-timeout.sh TIMEOUT_IN_SECONDS CMD
Example: retry-until-timeout.sh 30 "./my-script-checking-deployment-is-ready.sh"
EOF
exit 1
fi


timeout -k 5s "${TIMEOUT}s" bash -c "until $CMD; do echo \"Failed. Sleep $INTERVAL seconds and try again\"; sleep $INTERVAL; done"

RESULT=$?

if [ $RESULT -eq 0 ]; then 
	echo "Command is succeed"
else
	echo "Command is failed" 1>&2
fi

exit $RESULT


