FROM centos:7

COPY fs /

RUN /tmp/update_base.sh || exit $?

RUN /tmp/install_packages.sh || exit $?

RUN /tmp/configure_packages.sh || exit $?

