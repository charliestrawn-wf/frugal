#!/usr/bin/env bash

set -ex

export FRUGAL_HOME=$GOPATH/src/github.com/Workiva/frugal
TEST_PATH=$FRUGAL_HOME/test/integration/java/frugal-integration-test

if [ -z "${IN_SKYNET_CLI+yes}" ]; then
    cp $SKYNET_APPLICATION_FRUGAL_ARTIFACTORY $TEST_PATH
else
    cd $FRUGAL_HOME/lib/java
    mvn clean package -DskipTests=true -Dsource.skip=true -Dmaven.javadoc.skip=true
    mv $(find target -type f -name 'frugal-*.*.*.jar') $TEST_PATH
fi

mvn -f $TEST_PATH/pom.xml clean install:install-file -Dfile=$(find $TEST_PATH -type f -name 'frugal-*.*.*.jar') -U -q
mvn -f $TEST_PATH/pom.xml clean compile assembly:single -U -q
