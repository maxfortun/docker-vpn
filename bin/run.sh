#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")
popd

. $SWD/setenv.sh

docker system prune -f

docker run -it $DOCKER_RUN_ARGS --privileged --cap-add SYS_ADMIN --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro $PORTS --name $NAME $REPO/$NAME-certs:$VERSION $*

