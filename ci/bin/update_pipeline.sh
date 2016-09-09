#!/bin/bash

set -e

TARGET=${TARGET:-"hybris"}
PIPELINE_NAME=${PIPELINE_NAME:-"riemann-boshrelease"}

if ! [ -x "$(command -v fly)" ]; then
  echo 'fly is not installed.' >&2
fi

CREDENTIALS=$(mktemp /tmp/credentials.XXXXX)

pull_credentials riemann concourse credentials.yml.erb ${CREDENTIALS}

fly -t ${TARGET} set-pipeline -c pipeline.yml --load-vars-from=${CREDENTIALS} --pipeline=${PIPELINE_NAME}
if [ $? -ne 0 ]; then
  echo "Please login first: fly -t ${TARGET} login -k"
fi

rm -f ${CREDENTIALS}
