#!/bin/bash
PROJECT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
STAGING_DIR="${PROJECT_DIR}/staging/${TRAVIS_REPO_SLUG}"
SOURCE_DIR="${TRAVIS_BUILD_DIR}/$1"

cd $PROJECT_DIR

git config user.name "Travis Build"
git config user.email "travis@travis-ci.org"

if [ -e $STAGING_DIR ]
then
    git rm -r "${STAGING_DIR}"
fi

mkdir -p "${STAGING_DIR}"
cp -r "${SOURCE_DIR}/*" "${STAGING_DIR}"
git add "${STAGING_DIR}"

git commit -m "Add artifacts from ${TRAVIS_REPO_SLUG} build ${TRAVIS_BUILD_ID}"
git push origin master