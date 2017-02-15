FROM ubuntu:wily
MAINTAINER Corentin Delcourt <codl@codl.fr>

RUN apt-get update && \
    apt-get install -y git cmake extra-cmake-modules qtbase5-dev g++ curl && \
    rm -rf /var/lib/apt/lists/*

ENV DRAWPILE_VERSION 1.0.6

RUN cd /tmp && \
    curl http://drawpile.net/files/src/drawpile-${DRAWPILE_VERSION}.tar.gz | gunzip | tar -x && \
    mkdir -p /tmp/drawpile-build && \
    cd /tmp/drawpile-build && \
    cmake /tmp/drawpile-${DRAWPILE_VERSION} -DCMAKE_INSTALL_PREFIX=/usr -DCLIENT=off && \
    make install && \
    useradd --system drawpile && \
    cd / && rm -rf /tmp/drawpile-${DRAWPILE_VERSION} /tmp/drawpile-build


ENTRYPOINT ["/usr/bin/drawpile-srv"]

USER drawpile
EXPOSE 27750
