#!/usr/bin/env bash
if [ "$TRAVIS_BRANCH" = 'travis_deploys' ] && [ "$TRAVIS_PULL_REQUEST" == 'false' ]; then
    mvn deploy -P sign,build-extras --settings $TRAVIS_BUILD_DIR/lib/java/.travis.settings.xml
fi
