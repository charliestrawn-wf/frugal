#!/usr/bin/env bash
if [ "$TRAVIS_BRANCH" = 'travis_deploys' ] && [ "$TRAVIS_PULL_REQUEST" == 'false' ]; then
    openssl aes-256-cbc -K $encrypted_e306f8772fe5_key -iv $encrypted_e306f8772fe5_iv -in codesigning.asc.enc -out codesigning.asc -d
    gpg --fast-import $TRAVIS_BUILD_DIR/scripts/travis/signingkey.asc
fi
