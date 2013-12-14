#!/bin/bash
PROJECT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
STAGING_DIR="${PROJECT_DIR}/staging/${TRAVIS_REPO_SLUG}"
SOURCE_DIR="${TRAVIS_BUILD_DIR}/$1"

echo "Project directory: ${PROJECT_DIR}"
echo "Staging directory: ${STAGING_DIR}"
echo "Source directory: ${SOURCE_DIR}"
echo "Project directory: ${PROJECT_DIR}"
echo "Username: ${GIT_NAME}"
echo "User email: ${GIT_EMAIL}"

cd $PROJECT_DIR

git config user.name "${GIT_NAME}"
git config user.email "${GIT_EMAIL}"
git config credential.helper "store --file=.git/credentials"
echo "https://${GITHUB_TOKEN}:@github.com" > .git/credentials

if [ -e $STAGING_DIR ]
then
    git rm -r "${STAGING_DIR}"
fi

mkdir -p "${STAGING_DIR}"
cp -r "${SOURCE_DIR}" "${STAGING_DIR}"
git add "${STAGING_DIR}"

git commit -m "Adding artifacts from ${TRAVIS_REPO_SLUG} build ${TRAVIS_BUILD_ID}"
git push origin master