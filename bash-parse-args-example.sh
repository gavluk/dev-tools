#!/bin/bash

echo -e "Script supports two parameters: \n--color COLOR (black by default)\n--profile PROFILE (plain by default)"

while [[ $# -gt 0 ]]; do
	case "$1" in
		--profile)
			PROFILE=$2
			shift 2;;

		--color)
			COLOR=$2
			shift 2;;

		*)
			break;;
	esac
done

PROFILE=${PROFILE:-plain}
COLOR=${COLOR:-black}

echo "==== RESULT ===="
echo "Profile: $PROFILE"
echo "Color: $COLOR"


