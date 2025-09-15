#!/bin/bash

FILE=$1

if [[ ! -f $FILE ]]; then
	echo "Cannot find a file '${FILE}'. Usage: 'gpg-decrypt.sh SOME.gpg'" 1>&2
	exit 1
fi

gpg -d --quiet --batch --passphrase ${GPG_PASSPHRASE} -i $FILE


