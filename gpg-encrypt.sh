#!/bin/bash -e

FILE=$1

if [[ ! -f $FILE ]]; then
	echo "Cannot find a file '${FILE}'. Usage: 'gpg-encrypt.sh SOME_FILE'" 1>&2
	exit 1
fi

ENCRYPTED_FILE="${FILE}.gpg"

gpg -c --batch --passphrase "$GPG_PASSPHRASE" -o "$ENCRYPTED_FILE" "$FILE"

echo "Encrypted file ${ENCRYPTED_FILE} created" 
