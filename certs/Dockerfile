ARG REPO
ARG NAME
ARG VERSION

FROM $REPO/$NAME-base:$VERSION

COPY fs /

RUN /tmp/configure_openvpn_certs.sh || exit $?

