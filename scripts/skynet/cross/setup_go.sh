#!/usr/bin/env bash

set -ex

export FRUGAL_HOME=$GOPATH/src/github.com/Workiva/frugal

if [ ! -e "$FRUGAL_HOME/lib/go/glide.lock" ]; then
    cd $FRUGAL_HOME/lib/go && glide install
fi

cd $FRUGAL_HOME

# Create Go binaries
rm -rf test/integration/go/bin/*
cd test/integration/go
glide install
go build testclient.go
go build testserver.go
