#!/usr/bin/env bash

set -ex

export FRUGAL_HOME=$GOPATH/src/github.com/Workiva/frugal
TEST_PATH=$FRUGAL_HOME/test/integration/java

if [ -z "${IN_SKYNET_CLI+yes}" ]; then
    cp $SKYNET_APPLICATION_FRUGAL_ARTIFACTORY $TEST_PATH/frugal-integration-test/frugal.jar
else
    cd $FRUGAL_HOME/lib/java
    mvn clean verify -q
    mv $(find target -type f -name 'frugal-*.*.*.jar' | grep -v sources | grep -v javadoc) $TEST_PATH/frugal-integration-test/frugal.jar
fi

cd $TEST_PATH/frugal-integration-test
mvn clean install:install-file -Dfile=frugal.jar -U -q

# Compile java tests
mvn clean compile assembly:single -U -q

mv $TEST_PATH/frugal-integration-test/target/frugal-integration-test-1.0-SNAPSHOT-jar-with-dependencies.jar $TEST_PATH/frugal-integration-test/cross.jar
