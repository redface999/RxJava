#!/bin/bash
# This script will build the project.

if [ "$TRAVIS_PULL_REQUEST" == "true" ]; then
  echo -e 'Build Pull Request => Branch ['$TRAVIS_BRANCH']'
  ./gradlew -Prelease.useLastTag=true build
elif [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_TAG" == "" ]; then
  echo -e 'Build Branch with Snapshot => Branch ['$TRAVIS_BRANCH']'
  ./gradlew -PbintrayUser="${bintrayUser}" -PbintrayKey="${bintrayKey}" snapshot --stacktrace
elif if [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_TAG" != "" ]; then
  echo -e 'Build Branch for Release => Branch ['$TRAVIS_BRANCH']  Tag ['$TRAVIS_TAG']'
  ./gradlew -Prelease.useLastTag=true -PbintrayUser="${bintrayUser}" -PbintrayKey="${bintrayKey}" final --stacktrace
else
  echo -e 'ERROR: Should not be here => Branch ['$TRAVIS_BRANCH']  Tag ['$TRAVIS_TAG']'
fi
