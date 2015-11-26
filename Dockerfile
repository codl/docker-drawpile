FROM ubuntu:wily
MAINTAINER Corentin Delcourt <codl@codl.fr>

RUN apt-get update && \
    apt-get install -y git cmake extra-cmake-modules qtbase5-dev g++ && \
    rm -rf /var/lib/apt/lists/*

ENV DRAWPILE_VERSION 1.0.1.1

RUN git clone https://github.com/callaa/Drawpile.git /tmp/drawpile && \
    cd /tmp/drawpile && \
    git checkout ${DRAWPILE_VERSION} && \
    mkdir -p /tmp/drawpile-build && \
    cd /tmp/drawpile-build && \
    cmake /tmp/drawpile -DCMAKE_INSTALL_PREFIX=/usr -DCLIENT=off && \
    make install && \
    useradd --system drawpile && \
    cd / && rm -rf /tmp/drawpile /tmp/drawpile-build


ENTRYPOINT ["/usr/bin/drawpile-srv"]

USER drawpile
EXPOSE 27750
