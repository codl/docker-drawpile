FROM ubuntu:utopic
MAINTAINER Corentin Delcourt <codl@codl.fr>

RUN apt-get update && \
    apt-get install -y git cmake extra-cmake-modules qtbase5-dev g++ && \
    git clone https://github.com/callaa/Drawpile.git /tmp/drawpile && \
    cd /tmp/drawpile && \
    git checkout $(git describe --tags --abbrev=0) && \
    mkdir -p /tmp/drawpile-build && \
    cd /tmp/drawpile-build && \
    cmake /tmp/drawpile -DCMAKE_INSTALL_PREFIX=/usr -DCLIENT=off && \
    make install && \
    cd / && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    useradd --system drawpile

ENTRYPOINT ["/usr/bin/drawpile-srv"]

USER drawpile
EXPOSE 27750
