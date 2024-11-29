#!/bin/bash


if [[ -z "${ARTIFACTORY_API}" ]] || [[ -z "${ARTIFACTORY_REPO}" ]]; then
	echo "ERROR: Env variables ARTIFACTORY_API and ARTIFACTORY_REPO is not set" 1>&2
	exit 1
fi

curl -s  \
  "${ARTIFACTORY_API}/search/versions?g=${1}&a=${2}&repos=${ARTIFACTORY_REPO}" \
    | jq -r '.results[].version' \
    | head -n 5

