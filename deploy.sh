#!/bin/sh

set -e
echo TRAVIS_COMMIT=${TRAVIS_COMMIT}
docker login -u ${DOCKERHUB_USERNAME} -p ${DOCKERHUB_PASSWORD}
tag="openturns/${IMAGE}"
docker tag ${tag}:${TRAVIS_COMMIT} ${tag}:latest
docker push ${tag}:latest
