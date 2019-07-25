#!/bin/sh

set -e

usage()
{
  echo "Usage: $0 image"
  exit 1
}

test $# = 1 || usage


if test "${CIRCLE_BRANCH}" != "master"
then
  echo "Not on master, aborting"
  exit 1
fi

if test -z "${DOCKERHUB_USERNAME}" -o -z "${DOCKERHUB_PASSWORD}"
then
  echo "DOCKERHUB_USERNAME, DOCKERHUB_PASSWORD env variables are not set"
  exit 1
fi

image=$1

docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}
docker push ${image}

