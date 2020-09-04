ARG REPO
ARG NAME
ARG VERSION
ARG LAST_LAYER

FROM $REPO/$NAME-$LAST_LAYER:$VERSION

COPY fs /

RUN /tmp/cleanup.sh

VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 1194/udp

CMD /usr/sbin/init
