#!/bin/bash
GITHUB_TOKEN=$1
GITHUB_REPO=$2
# FIRST_VAR could be "QUAY_USERNAME"
FIRST_VAR=$3
# SECOND_VAR could be "QUAY_PASSWORD"
# if deleting a single secret, omit SECOND_VAR
SECOND_VAR=$4

echo -n "Number of secrets [before]: "
curl -sSL -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_REPO}/actions/secrets | jq '.total_count'

curl -sSL -H "Authorization: token ${GITHUB_TOKEN}"  -X DELETE -H "Content-Type: application/json" https://api.github.com/repos/${GITHUB_REPO}/actions/secrets/${FIRST_VAR}
if [ "${SECOND_VAR}" ]; then
    curl -sSL -H "Authorization: token ${GITHUB_TOKEN}"  -X DELETE -H "Content-Type: application/json" https://api.github.com/repos/${GITHUB_REPO}/actions/secrets/${SECOND_VAR}
fi

echo -n "Number of secrets [after]: "
curl -sSL -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/${GITHUB_REPO}/actions/secrets | jq '.total_count'
echo ""
