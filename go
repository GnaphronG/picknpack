#!/bin/sh
#
# Run go in a container
#
# This script will attempt to mirror the host paths by using volumes for the
# following paths:
#   * $(pwd)
#   * $(dirname $GOPATH) if it's set
#
# You can add additional volumes (or any docker run options) using
# the $DOCKER_RUN_OPTIONS environment variable.
#


set -e

VERSION=${VERSION:-"1.8.3"}
IMAGE="golang:$VERSION"
ENTRYPOINT="go"
USER=$(id -u)
GROUP=$(id -g)

for goenv in `env | grep -E -o '^C?GO[A-Z0-9_]+=.*$'`; do
    GOLANG_OPTIONS="$GOLANG_OPTIONS -e $goenv"
done	

if [ -n "$GOPATH" ]; then
    VOLUMES="$VOLUMES -v $GOPATH:$GOPATH"
    GOLANG_OPTIONS="$GOLANG_OPTIONS -e GOPATH=$GOPATH"
else
    VOLUMES="$VOLUMES -v $(pwd):$(pwd)"	
fi

# Only allocate tty if we detect one
if [ -t 1 ]; then
    DOCKER_RUN_OPTIONS="-t"
fi
if [ -t 0 ]; then
    DOCKER_RUN_OPTIONS="$DOCKER_RUN_OPTIONS -i"
fi

exec docker run --rm -u $USER:$GROUP $VOLUMES $GOLANG_OPTIONS -v /etc/passwd:/etc/passwd -w $(pwd) --entrypoint $ENTRYPOINT $IMAGE "$@"
