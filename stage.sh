#!/bin/bash
PROJECT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
STAGING_DIR="${PROJECT_DIR}/staging/${TRAVIS_REPO_SLUG}"

git config credential.helper "store --file=.git/credentials"
echo "https://${GITHUB_TOKEN}:@github.com" > .git/credentials
git remote add origin https://github.com/burnnat/p2

cd $PROJECT_DIR
if [ -e $STAGING_DIR ]
then
    git rm -r "${STAGING_DIR}"
fi

cp -r "$1" "${STAGING_DIR}"
git add "staging/${TRAVIS_REPO_SLUG}"

git commit -m "Adding artifacts from ${TRAVIS_REPO_SLUG} build ${TRAVIS_BUILD_ID}"
git push origin $TRAVIS_BRANCH