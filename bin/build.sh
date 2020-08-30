#!/bin/bash -ex

pushd "$(dirname $0)"
SWD=$(pwd)
BWD=$(dirname "$SWD")
popd

. $SWD/setenv.sh

[ ! -d  ssh/fs/root/.ssh ] && mkdir -p ssh/fs/root/.ssh && chmod og-rwx ssh/fs/root/.ssh
cp ~/.ssh/id_rsa.pub ssh/fs/root/.ssh/authorized_keys

for layer in base certs openvpn firewall ssh run; do
	docker build ${DOCKER_BUILD_ARGS[*]} ${LAST_LAYER_ARGS[*]} --rm -t "$REPO/$NAME-$layer:$VERSION" $layer

	dockerImages=$(docker images "$REPO/$NAME-$layer" -f "before=$REPO/$NAME-$layer:$VERSION" -q)
	[ -n "$dockerImages" ] && docker rmi -f $dockerImages || true
	LAST_LAYER_ARGS=( --build-arg LAST_LAYER=$layer )
done
