#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")
popd

. $SWD/setenv.sh

RUN_IMAGE="$REPO/$NAME-run"

imageId=$(docker images --format="{{.Repository}} {{.ID}}"|grep "^$RUN_IMAGE "|awk '{ print $2 }')
DOCKER_PORT_ARGS=()
while read port; do
	hostPort=$DOCKER_PORT_PREFIX${port%%/*}
	[ ${#hostPort} -gt 5 ] && hostPort=${hostPort:${#hostPort}-5}
	DOCKER_PORT_ARGS+=( -p $hostPort:$port )
done < <(docker image inspect -f '{{json .Config.ExposedPorts}}' $imageId|jq -r 'keys[]')

docker stop $NAME || true

docker system prune -f

DOCKER_RUN_ARGS+=( -e container=docker )

docker run -d -it --privileged --cap-add=NET_ADMIN --cap-add=MKNOD --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro ${DOCKER_PORT_ARGS[*]} ${DOCKER_RUN_ARGS[*]} --name $NAME $RUN_IMAGE:$VERSION $*
echo "Attaching to container. To detach CTRL-P CTRL-Q."
docker attach $NAME
