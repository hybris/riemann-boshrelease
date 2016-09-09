#!/bin/bash

set -e

TARGET=${TARGET:-"hybris"}
PIPELINE_NAME=${PIPELINE_NAME:-"riemann-boshrelease"}
CREDENTIALS=$(mktemp /tmp/credentials.XXXXX)

if ! [ -x "$(command -v fly)" ]; then
  echo 'fly is not installed.' >&2
fi

pull_credentials riemann concourse credentials.yml.erb ${CREDENTIALS}

fly -t ${TARGET} set-pipeline -c pipeline.yml -l ${CREDENTIALS} -p ${PIPELINE_NAME}
